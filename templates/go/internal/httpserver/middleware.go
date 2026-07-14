package httpserver

import (
	"context"
	"log"
	"net/http"
	"time"
)

// timeoutMiddleware bounds each request to _requestTimeout by attaching a
// deadline to the request context, so handlers and the database queries they
// run are cancelled once the deadline passes.
func timeoutMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		ctx, cancel := context.WithTimeout(r.Context(), _requestTimeout)
		defer cancel()
		next.ServeHTTP(w, r.WithContext(ctx))
	})
}

// statusRecorder wraps http.ResponseWriter to capture the response status code.
type statusRecorder struct {
	http.ResponseWriter
	status int
}

func (r *statusRecorder) WriteHeader(status int) {
	r.status = status
	r.ResponseWriter.WriteHeader(status)
}

func loggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		start := time.Now()

		// Default to 200: a handler that writes a body without calling
		// WriteHeader implicitly sends 200 OK.
		recorder := &statusRecorder{ResponseWriter: w, status: http.StatusOK}

		next.ServeHTTP(recorder, r)

		log.Printf(
			"%s %s %s %d %s",
			r.Method,
			r.RequestURI,
			r.RemoteAddr,
			recorder.status,
			time.Since(start),
		)
	})
}
