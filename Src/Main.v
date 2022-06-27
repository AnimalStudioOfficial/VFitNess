//Read File lines in to array:
// 	data := os.read_lines("test.txt") or {
//		println("File can't be read!")
//		return
//	}
//   println(data)

import os
import nedpals.vargs // or import nedpals.vargs for vpm users
import term

const (
	debug_mode = true
	version = "0.9"
)


fn quit_promt(){
	term.clear() // clears the content in the terminal
    width, height := term.get_terminal_size() // get the size of the terminal
    term.set_cursor_position(x: width / 2, y: height / 2) // now we point the cursor to the middle of  the terminal
    //println(term.strikethrough(term.bright_green('hello world'))) // Print green text
    term.set_cursor_position(x: 0, y: height) // Sets the position of the cursor to the bottom of the terminal
    // Keep prompting until the user presses the q key
    for {
        if var := os.input_opt('press q to quit: ') {
            if var != 'q' {
                continue
            }
            break
        }
        println('')
        break
    }
    println('Goodbye.')
	exit(0)
}

fn about_cmd(){
term.clear() // clears the content in the terminal
println("VFitNess "+version)
println("------------------")
println("By AnimalStudioOfficial")
println("Made with Vlang")
}

fn food() {
    println("Welcome To Food")
    food_user_input := os.input('What do you want to do:')
 match food_user_input {
	'about' { about_cmd() }
    'add' {  }
	'quit' { exit(0) }
	else { println(food_user_input+" is NOT a command") }
 }
}

fn main(){
 println("Welcome To VFitNess")
 // read text from stdin
 user_input := os.input('What do you want to do:')
match user_input {
	'about' { about_cmd() }
	'quit' { exit(0) }
	else { println(user_input+" is NOT a command") }
}


}