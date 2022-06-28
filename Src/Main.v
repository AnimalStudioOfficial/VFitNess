//Read File lines in to array:
// 	data := os.read_lines("test.txt") or {
//		println("File can't be read!")
//		return
//	}
//   println(data)
//base58:
//println(base58.encode("hi my name is kitty"))
//println(base58.decode("L7ePLCWabRnveKEA7exawrEx64")?)
//Clipboard:
//mut c := clipboard.new()
//c.copy('I am a good boy!')

import os
import term
import runtime
import time
import clipboard
//import net.http
//import encoding.base58

import nedpals.vargs // or import vargs for vpkg users
import serkonda7.termtable as tt
import etienne_napoleone.chalk

enum State {
	normal
	write_log
	return_error
}

const (
	debug_mode = true
	version = "0.02"
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

fn help_cmd() {
data := [
		['Number', 'Name', 'Dec'],
		['1', 'food', 'food tracking'],
		['2', 'about', 'VFitNess about'],
		['3', 'quit', 'exit the app'],
        ['4', 'info', 'pc info'],
	]
	t := tt.Table{
		data: data
		// The following settings are optional and have these defaults:
		style: .fancy_grid
		header_style: .bold
		align: .left
		orientation: .row
		padding: 1
		tabsize: 4
	}
	println(t)
}

fn pc_info() {
println("OS: "+os.user_os())

if runtime.is_32bit() == true && runtime.is_32bit() != false && runtime.is_64bit() == false { //32bit os
println("Bit: 32")
}
else if runtime.is_64bit() == true && runtime.is_64bit() != false && runtime.is_32bit() == false { //64bit os
println("Bit: 64")
}

print("virtual CPU cores: ")
print(runtime.nr_cpus())
println("") 

time.sleep(2)
}

//OLD
//fn food_add() {
//food_add_user_input := os.input('What do you want to do:')
//}

//Food
//Fat
fn add_fat_file_input(s State) ?int {
 add_fat_file_input := os.input('Do you want to create the fat.txt file:').to_lower()
if add_fat_file_input == 'yes' || add_fat_file_input == 'y' {
mut f := os.create('data/fat.txt')?
return f.writeln('0g')
}
else if add_fat_file_input == 'no' || add_fat_file_input == 'n' {
exit(1)
}
 return 0
}
//proteins
fn add_proteins_file_input(s State) ?int {
 add_proteins_file_input := os.input('Do you want to create the proteins.txt file:').to_lower()
if add_proteins_file_input == 'yes' || add_proteins_file_input == 'y' {
mut f := os.create('data/proteins.txt')?
return f.writeln('0g')
}
else if add_proteins_file_input == 'no' || add_proteins_file_input == 'n' {
exit(1)
}
 return 0
}

fn food(s State) ?int {
  
//Stats
 mut fat := "g" //Add g to the end of the string to repesent grams
 mut proteins := "g" //Add g to the end of the string to repesent grams

//Read Stats files
//Fat file
mut is_fat_file := os.is_file("data/fat.txt")
if is_fat_file == true && is_fat_file != false{
   // println("true")
    //TODO add check is_readable() fn to fat file

    data := os.read_file("data/fat.txt")?
    fat = data
  //println(data)


 //println(fat)
}
else if is_fat_file == false && is_fat_file != true{
    //println("false")
    println(chalk.fg(chalk.style('[ERROR]', 'bold'), 'red')+' fat.txt is not a file or does not exist')

    n := add_fat_file_input(.return_error) or {
		println('Error: $err')
		0
	}
	println('$n bytes written')
    
    exit(1)
}
//proteins file
mut is_proteins_file := os.is_file("data/proteins.txt")
if is_proteins_file == true && is_proteins_file != false{
   // println("true")
    //TODO add check is_readable() fn to proteins file

    data := os.read_file("data/proteins.txt")?
    proteins = data
  //println(data)


 //println(proteins)
}
else if is_proteins_file == false && is_proteins_file != true{
    //println("false")
    println(chalk.fg(chalk.style('[ERROR]', 'bold'), 'red')+' proteins.txt is not a file or does not exist')

    n := add_proteins_file_input(.return_error) or {
		println('Error: $err')
		0
	}
	println('$n bytes written')
    
    exit(1)
}




start:
    println("Welcome To Food")
    food_user_input := os.input('What do you want to do:')
 match food_user_input {
    'stats' { goto stats }
    'add' { unsafe {goto food_add}}
    'about' { about_cmd() }
	'quit' { exit(0) }
	else { println(food_user_input+" is NOT a command") }
 }
food_add:
 food_add_fat_user_input := os.input('What do you want to add to Fat:') //Fat input
fat = food_add_fat_user_input + 'g' //Add g to the end of the string to repesent grams

food_add_proteins_user_input := os.input('What do you want to add to proteins:') //proteins input
proteins = food_add_proteins_user_input + 'g' //Add g to the end of the string to repesent grams

goto write_stats_to_file
goto start
stats:
//fat
 println("Fat: "+fat)
 //proteins
 println("Proteins:"+proteins)
 goto start
write_stats_to_file:
//fat file
 mut f := os.create('data/fat.txt')?
 defer {
 f.close()
 }
 f.writeln(fat)?
 //proteins file
 mut p := os.create('data/proteins.txt')?
 defer {
 p.close()
 }
 p.writeln(proteins)?
 goto start
   return 0
}

//OLD
//println("Welcome To VFitNess "+version)

fn best_protein() {
println("Here are some results:")
best_protein_data := [
		['Number', 'Name'],
		['1', '16 Delicious High Protein Foods'],
		['2', 'soon'],
		['3', 'soon'],
        ['4', 'soon'],
	]
	t := tt.Table{
		data: best_protein_data
		// The following settings are optional and have these defaults:
		style: .fancy_grid
		header_style: .bold
		align: .left
		orientation: .row
		padding: 1
		tabsize: 4
	}
	println(t)

best_protein_user_input := os.input('What do you want to Look for:').to_lower()
match best_protein_user_input {
    '1' { goto num1 }
    'about' { about_cmd() }
	'quit' { exit(0) }
	else { println(best_protein_user_input+" is NOT a command") }
}
num1:
}

fn best_cmd() {
best_user_input := os.input('What do you want to Look for:').to_lower()
match best_user_input {
    'protein' { best_protein() }
    'about' { about_cmd() }
	'quit' { exit(0) }
	else { println(best_user_input+" is NOT a command") }
}

}

fn main(){
mut data_dir_exists := os.exists("data") //Check if data dir exists
if data_dir_exists == true && data_dir_exists != false { //data dir exists
println("[DEBUG] data dir exists: true")

}
else if data_dir_exists == false && data_dir_exists != true { //data dir does NOT exist
    println("[DEBUG] data dir exists: false")
    os.mkdir("data") or { panic("err") } //Create the data directory

    //Check if the data directory is writable folder
    mut data_dir_is_writeable := os.is_writable_folder("data")? //Check if data dir is writable folder
    if data_dir_is_writeable == true && data_dir_is_writeable != false { //data dir is a writable folder

    }
    else if data_dir_is_writeable == false && data_dir_is_writeable != true { //data dir is NOT a writable folder

    }
}

//Print welcome message
    data := [
		["Welcome To VFitNess "+version],

	]
	t := tt.Table{
		data: data
		// The following settings are optional and have these defaults:
		style: .fancy_grid
		header_style: .bold
		align: .left
		orientation: .row
		padding: 1
		tabsize: 4
	}
	println(t)
help_cmd()
 // read text from stdin
 user_input := os.input('What do you want to do:').to_lower()
match user_input {
    'food' { food(.return_error)? }
    'info' { pc_info() }
    'best' { best_cmd() }
    'about' { about_cmd() }
	'quit' { exit(0) }
	else { println(user_input+" is NOT a command") }
}


}