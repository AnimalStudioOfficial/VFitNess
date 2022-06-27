//Read File lines in to array:
// 	data := os.read_lines("test.txt") or {
//		println("File can't be read!")
//		return
//	}
//   println(data)

import os
import nedpals.vargs // or import nedpals.vargs for vpm users
import term

enum State {
	normal
	write_log
	return_error
}

const (
	debug_mode = true
	version = "0.01"
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


//OLD
//fn food_add() {
//food_add_user_input := os.input('What do you want to do:')
//}

fn food(s State) ?int {
  
//Stats
 mut fat := "g"

//Read Stats files
mut is_fat_file := os.is_file("fat.txt")
if is_fat_file == true {
    println("f")
}


start:
    println("Welcome To Food")
    food_user_input := os.input('What do you want to do:')
 match food_user_input {
    'stats' {  }
    'add' { goto food_add }
    'about' { about_cmd() }
	'quit' { exit(0) }
	else { println(food_user_input+" is NOT a command") }
 }
food_add:
 food_add_fat_user_input := os.input('What do you want to add to Fat:') //Fat input
fat = food_add_fat_user_input + 'g'
goto write_stats_to_file
goto start
stats:
 println("Fat: "+fat)
 goto start
write_stats_to_file:
 mut f := os.create('fat.txt')?
 defer {
 f.close()
 }
 f.writeln(fat)?
   return 0
}

fn main(){
 println("Welcome To VFitNess")
 // read text from stdin
 user_input := os.input('What do you want to do:')
match user_input {
	'about' { about_cmd() }
    'food' { food(.return_error)? }
	'quit' { exit(0) }
	else { println(user_input+" is NOT a command") }
}


}