package main

import (
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

	http.ListenAndServe(":8080", mux)
}
