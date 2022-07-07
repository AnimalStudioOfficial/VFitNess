// Print file lines that start with "DEBUG:"
import os
import time
import net.http

import serkonda7.termtable as tt

const (
	debug_mode = true
	//version = "0.04"
)


fn help_cmd() {
data := [
		['Number', 'Name', 'Dec'],
		['1', 'run', 'run a sh file'],
		['2', 'about', 'sh about'],
		['3', 'quit', 'exit the app'],
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

fn main() {

//mut file_to_run := ''

mut reg_1 := ''
mut reg_2 := ''
mut reg_3 := ''
mut reg_4 := ''



println('Welcome to sh')
println('-------------')
help_cmd()

user_input := os.input('What do you want to do:').to_lower()
        match user_input {
                'run' { unsafe{goto run_menu} }
                'about' {  }
                'quit' { exit(0) }
                else { println(user_input + ' is NOT a command') }
        }

run_menu: //run_menu
run_menu_user_input := os.input('path to file to run:')
unsafe{goto run}
run: //Run

sw := time.new_stopwatch() //Run stopwatch


// `read_file` returns an optional (`?string`), it must be checked
text := os.read_file(run_menu_user_input) or {panic(err)}

if debug_mode == true {
println('[DEBUG] Opened '+run_menu_user_input+' file')
}
else if debug_mode == false {

}

lines := text.split_into_lines()
for line in lines {
    if line.starts_with('add:') { //add
        //println(line)
		mut add_arg := line.after(':')
		//println(add_arg)
		mut add_num := add_arg.split(',')
		//mut add_num2 := add_num.int()
		//println(add_num)
		mut done_num := '0'

		mut is_reg1 := false
		mut is_reg2 := false
		mut is_reg3 := false
		mut is_reg4 := false

		for adder in add_num {
			if adder == 'reg1' {
				is_reg1 = true

			}
			else if adder == 'reg2' {
				is_reg2 = true
			}
			else if adder == 'reg3' {
				is_reg3 = true
			}
			else if adder == 'reg4' {
				is_reg4 = true
			}
			mut addgyurw := adder.int()
			mut done_num2 := done_num.int()
			mut gh := done_num2 + addgyurw
			done_num = gh.str()
		}
		if is_reg1 == true {
			reg_1 = done_num

		}
		else if is_reg2 == true {
			reg_2 = done_num
		}
		else if is_reg3 == true {
			reg_3 = done_num
		}
		else if is_reg4 == true {
			reg_4 = done_num
		}
		//println(done_num)
		//println(reg_1)
		//println(reg_2)
		//println(reg_3)
		//println(reg_4)

		
    }
	else if line.starts_with('print:') { //print
        ///println(line)
		mut print_arg := line.after(':')
	match print_arg {
	'reg1' { println(reg_1) }
	'reg2' { println(reg_2) }
	'reg3' { println(reg_3) }
	'reg4' { println(reg_4) }
	else { println(print_arg + " is not a reg number") }
}

    }
	else if line.starts_with('reg1:') { //reg1
        ///println(line)
		mut reag1_arg := line.after(':')
		reg_1 = reag1_arg

		//println(print_arg)
		//mut print_string := print_arg.split(',')
		//mut add_num2 := add_num.int()
		//println(add_num)
		
    }
	else if line.starts_with('cmd:') { //cmd
        ///println(line)
		mut cmd_arg := line.after(':')
		os.execute_or_panic(cmd_arg)

		//println(print_arg)
		//mut print_string := print_arg.split(',')
		//mut add_num2 := add_num.int()
		//println(add_num)
		
    }
	else if line.starts_with('mkdir:') { //mkdir
        ///println(line)
		mut mkdir_arg := line.after(':')
		os.mkdir(mkdir_arg) or {panic(err)}

		//println(print_arg)
		//mut print_string := print_arg.split(',')
		//mut add_num2 := add_num.int()
		//println(add_num)
		
    }
	else if line.starts_with('rmdir:') { //rmdir
        ///println(line)
		mut rmdir_arg := line.after(':')
		mut is_dir := os.is_dir(rmdir_arg)
		if is_dir == true {
			os.rmdir(rmdir_arg) or {panic(err)}
		}
		else if is_dir == false {
			println("Error "+rmdir_arg+" is not a dir")
		}
		else {
			println("Error with is_dir: "+rmdir_arg)
		}
		
		
    }
	
}

if debug_mode == true {
println('[DEBUG] compile took: ${sw.elapsed().seconds()}seconds')
}
else if debug_mode == false {

}

}