#!/usr/bin/bash

read -p "Please Enter the Plaintext: " plaintext
read -p "Please enter number of shift: "  shiftN

#plaintext="$1"
#shiftN="$2"

# for executing the script in a single command by passing plaintext and shift
# as arguments, uncomment line 6 & 7 and comment line 3 & 4
# bash caesarNrot.sh "your plaintext/cipherText" "shift number"
# example: bash caesarNrot.sh "abcdef hello!" 13

abc="abcdefghijklmnopqrstuvwxyz"
plaintext=$(echo $plaintext | tr '[:upper:]' '[:lower:]')


function encrypt(){

	for ((i=0;i<${#plaintext};i++)); do
		character=${plaintext:i:1}
		findIndex=${abc%%$character*}
		value=$((${#findIndex}+shiftN))

		if [[ ${#findIndex} -eq 26 ]]; then
			cipherText+=$character
		
		elif [[ $value -gt 25 ]]; then 
				let value-=1 
				cipherText+=${abc:$((${value}%25)):1}
		else
				cipherText+=${abc:value:1}
		fi

	done
}

function decrypt(){
	for ((i=0;i<${#plaintext};i++)); do
		character=${plaintext:i:1}
		findIndex=${abc%%$character*}
		value=$((${#findIndex}-shiftN))
		if [[ ${#findIndex} -eq 26 ]]; then 
				plainText+=$character
		elif [[ $value -lt 0 ]]; then 
			let value+=1
			plainText+=${abc:$((25+${value})):1}
		else 
			plainText+=${abc:value:1}
		fi

	done

}

encrypt; decrypt
echo "The plaintext (shift-left by "$shiftN") is: " $plainText
echo "The ciphertext (shift-right by "$shiftN") is: " $cipherText

#echo $cipherText
