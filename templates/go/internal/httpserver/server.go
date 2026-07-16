package httpserver

import (
	"context"
	"encoding/json"
	"errors"
	"fmt"
	"log"
	"net/http"
	"strings"
	"time"

	"github.com/dmulholl/module-template/internal/models"
)

// _requestTimeout bounds the total time a request handler may spend.
const _requestTimeout = 5 * time.Second

type Server struct {
	httpServer *http.Server
}

func NewServer(addr string) *Server {
	s := &Server{}

	mux := http.NewServeMux()
	mux.HandleFunc("/get-object", s.HandleGetObject)
	mux.HandleFunc("/health", s.HandleHealthCheck)
	mux.HandleFunc("/", s.HandleNotFound)

	s.httpServer = &http.Server{
		Addr:         addr,
		Handler:      loggingMiddleware(timeoutMiddleware(mux)),
		ReadTimeout:  10 * time.Second,
		WriteTimeout: 10 * time.Second,
		IdleTimeout:  60 * time.Second,
	}

	return s
}

// Handler returns the server's HTTP handler. It is primarily useful for tests
// that want to exercise the routes without binding a network listener.
func (s *Server) Handler() http.Handler {
	return s.httpServer.Handler
}

func (s *Server) Serve(ctx context.Context) error {
	errChan := make(chan error, 1)

	go func() {
		err := s.httpServer.ListenAndServe()
		if errors.Is(err, http.ErrServerClosed) {
			err = nil
		}
		errChan <- err
	}()

	select {
	case err := <-errChan:
		return err

	case <-ctx.Done():
		shutdownCtx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
		defer cancel()

		if err := s.httpServer.Shutdown(shutdownCtx); err != nil {
			return fmt.Errorf("failed to shut down http server: %w", err)
		}

		return nil
	}
}

func (s *Server) HandleGetObject(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodGet {
		writeMethodNotAllowed(w, http.MethodGet)
		return
	}

	object := &models.Object{
		ID:   "id-123",
		Name: "Object 123",
		Type: "type-123",
	}

	writeJSON(w, http.StatusOK, struct {
		Status string         `json:"status"`
		Object *models.Object `json:"object"`
	}{
		Status: "success",
		Object: object,
	})
}

func (s *Server) HandleHealthCheck(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodGet {
		writeMethodNotAllowed(w, http.MethodGet)
		return
	}

	writeJSON(w, http.StatusOK, map[string]string{"status": "healthy"})
}

// HandleNotFound is the catch-all handler for unregistered routes. It ensures
// that every response from the server is a JSON object.
func (s *Server) HandleNotFound(w http.ResponseWriter, r *http.Request) {
	writeJSONError(w, "not found", http.StatusNotFound)
}

// writeJSON marshals v and writes it as a JSON response with the given status
// code. Every JSON response from the server goes through this helper so they
// share a consistent Content-Type and security header.
func writeJSON(w http.ResponseWriter, statusCode int, v any) {
	body, err := json.Marshal(v)
	if err != nil {
		log.Printf("error: failed to marshal response: %s", err)
		body = []byte(`{"status":"error","error":"internal server error"}`)
		statusCode = http.StatusInternalServerError
	}

	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("X-Content-Type-Options", "nosniff")
	w.WriteHeader(statusCode)

	if _, err := w.Write(body); err != nil {
		log.Printf("error: failed to write response: %s", err)
	}
}

// writeMethodNotAllowed writes a 405 response, advertising the permitted methods
// in the Allow header as required by RFC 7231.
func writeMethodNotAllowed(w http.ResponseWriter, allowed ...string) {
	w.Header().Set("Allow", strings.Join(allowed, ", "))
	writeJSONError(w, "method not allowed", http.StatusMethodNotAllowed)
}

// writeJSONError writes a JSON error response with the given message and status code.
func writeJSONError(w http.ResponseWriter, message string, statusCode int) {
	writeJSON(w, statusCode, map[string]string{
		"status": "error",
		"error":  message,
	})
}
