import os

const (
	debug_mode = true
	version = "0.9"
)

fn about_cmd(){
println("VFitNess "+version)
}

fn main(){
 println("Welcome To VFitNess")
 // read text from stdin
 user_input := os.input('What do you want to do:')
match user_input {
	'about' { about_cmd() }
	//'linux' { println('Linux.') }
	else { println(user_input+"is NOT a command") }
}


}