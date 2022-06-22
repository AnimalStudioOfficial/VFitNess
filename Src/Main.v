import os

const (
	debug_mode = true
)

fn main(){
 println("Welcome To VFitNess")
 // read text from stdin
 user_input := os.input('What do you want to do:')
match user_input {
	'about' { println('') }
	//'linux' { println('Linux.') }
	else { println(user_input+"is NOT a command") }
}


}