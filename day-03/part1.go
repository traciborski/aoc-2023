package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"unicode"
)

func main() {
	readFile, err := os.Open("input")
	defer readFile.Close()

	if err != nil {
		fmt.Println(err)
	}
	fileScanner := bufio.NewScanner(readFile)

	fileScanner.Split(bufio.ScanLines)

	var runes [][]rune

	for fileScanner.Scan() {
		line := fileScanner.Text()
		runes = append(runes, []rune(line))
	}

	sum := 0

	for i := 0; i < len(runes); i++ {

		start := -1
		end := -1

		for j := 0; j < len(runes[i]); j++ {

			if unicode.IsDigit(runes[i][j]) {
				if start != -1 {
					end = j
				} else {
					start = j
					end = j
				}
			} else {
				if start != -1 {
					if isPart(runes, i, start, end) {
						d, err := strconv.Atoi(string(runes[i][start : end+1]))
						if err != nil {
							panic("")
						}
						print(d)
						print(" ")
						sum += d
					}
					start = -1
					end = -1
				}
			}
		}
		if start != -1 && isPart(runes, i, start, end) {
			d, err := strconv.Atoi(string(runes[i][start : end+1]))
			if err != nil {
				panic("")
			}
			print(d)
			print(" ")
			sum += d
		}
		println()
	}

	println()
	println()
	println(sum)
}

func isPart(runes [][]rune, i, start, end int) bool {
	for j := start - 1; j <= end+1; j++ {
		if j >= 0 && i > 0 && j+1 < len(runes[i-1]) && isSymbol(runes[i-1][j]) {
			return true
		}
		if j >= 0 && i+1 < len(runes) && j < len(runes[i+1]) && isSymbol(runes[i+1][j]) {
			return true
		}
	}
	if start > 0 && isSymbol(runes[i][start-1]) {
		return true
	}
	if end+1 < len(runes[i]) && isSymbol(runes[i][end+1]) {
		return true
	}
	return false
}

func isSymbol(r rune) bool {
	s := string(r)
	return s == "%" || s == "/" || s == "*" || s == "$" || s == "+" || s == "-" || s == "@" || s == "#" || s == "=" || s == "&"
}
