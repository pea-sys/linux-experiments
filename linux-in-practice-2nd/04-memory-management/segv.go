package main

import "fmt"

func main(){
	var p *int =nil
	fmt.Println("メモリ不正アクセス前")
	*p=0
	fmt.Println("メモリ不正アクセス後")
}
