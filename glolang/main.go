package main

import (
	"io/ioutil"
	"log"
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
    defer r.Body.Close()
    body, err := ioutil.ReadAll(r.Body)
    if err != nil {
      log.Fatalf("Failed to read body:  %v", err)
    }
    w.Write(body)
  })

  http.ListenAndServe(":8080", mux)
}
