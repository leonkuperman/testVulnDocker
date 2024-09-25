package main

import (
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintln(w, "hello I'm vulnerable!")
}

func main() {
    http.HandleFunc("/", handler)
    fmt.Println("Server is running on port 3000...")
    http.ListenAndServe(":3000", nil)
}