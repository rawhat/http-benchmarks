package main

import (
	"fmt"
	"net/http"
	"strings"
)

func main() {
	mux := http.NewServeMux()

	mux.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		w.Write([]byte{})
	})
	mux.HandleFunc("/user/", func(w http.ResponseWriter, r *http.Request) {
		id := strings.TrimPrefix(r.URL.Path, "/user/")
		w.Write([]byte(id))
	})
	mux.HandleFunc("/user", func(w http.ResponseWriter, r *http.Request) {
		r.Write(w)
	})

	// err := http.ListenAndServeTLS(":3334", "/home/alex/gleams/mist/domain.crt", "/home/alex/gleams/mist/domain.key", mux)
	err := http.ListenAndServe(":8080", mux)
	if err != nil {
		fmt.Printf("Failed to start:  %w", err)
	}
}
