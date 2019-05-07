package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	word := (os.Args[1:2])[0]

	if word[0] <= 'Z' {
		fmt.Println(strings.ToLower(word))
		return
	}
	fmt.Println(strings.ToUpper(word))
}
