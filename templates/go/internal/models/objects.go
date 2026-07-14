package models

type Object struct {
	ID   string `db:"object_id" json:"id"`
	Name string `db:"object_name" json:"name"`
	Type string `db:"object_type" json:"type"`
}
