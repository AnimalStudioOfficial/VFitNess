// Print file lines that start with "DEBUG:"
import os



fn main() {

mut reg_1 := ''
mut reg_2 := ''
mut reg_3 := ''
mut reg_4 := ''

// `read_file` returns an optional (`?string`), it must be checked
text := os.read_file('test.txt') or {panic(err)}

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
		//println(print_arg)
		//mut print_string := print_arg.split(',')
		//mut add_num2 := add_num.int()
		//println(add_num)
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
}

}