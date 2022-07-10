// Print file lines that start with "DEBUG:"
import os
import time
import benchmark
import net.http
import rand
import regex

import serkonda7.termtable as tt

const (
	debug_mode = true
	//version = "0.04"
)

struct Regs {
	
}

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

//fn time() {
//println(time.day_of_week(2022,7,9))
//}

const numeric_char = [`0`, `1`, `2`, `3`, `4`, `5`, `6`, `7`, `8`, `9`, `.`, `e`, `E`]

// Convert expression to Reverse Polish Notation.
fn expr_to_rev_pol(expr string) ?[]string {
	if expr == '' {
		return error('err: empty expression')
	}
	mut stack := []string{}
	mut rev_pol := []string{}
	mut pos := 0
	for pos < expr.len {
		mut end_pos := pos
		for end_pos < expr.len && expr[end_pos] in numeric_char {
			end_pos++
		}
		if end_pos > pos {
			stack << expr[pos..end_pos]
			pos = end_pos
		} else if end_pos == pos {
			op := expr[pos].ascii_str()
			match op {
				'(' {
					stack << op
				}
				'*', '/' {
					for stack.len > 0 && stack.last() !in ['(', '+', '-'] {
						rev_pol << stack.last()
						stack.delete(stack.len - 1)
					}
					stack << op
				}
				'+', '-' {
					for stack.len > 0 && stack.last() != '(' {
						rev_pol << stack.last()
						stack.delete(stack.len - 1)
					}
					stack << op
				}
				')' {
					for stack.len > 0 && stack.last() != '(' {
						rev_pol << stack.last()
						stack.delete(stack.len - 1)
					}
					stack.delete(stack.len - 1)
				}
				else {
					return error('err: invalid character `$op`')
				}
			}
			pos++
		}
	}
	for stack.len > 0 {
		top := stack.last()
		rev_pol << top
		stack.delete(stack.len - 1)
	}
	return rev_pol
}

// Evaluate the result of Reverse Polish Notation.
fn eval_rev_pol(rev_pol []string) ?f64 {
	mut stack := []f64{}
	for item in rev_pol {
		if is_num_string(item) {
			stack << item.f64()
		} else {
			if stack.len >= 2 {
				oprand_r := stack.last()
				stack.delete(stack.len - 1)
				oprand_l := stack.last()
				stack.delete(stack.len - 1)
				match item {
					'+' {
						stack << oprand_l + oprand_r
					}
					'-' {
						stack << oprand_l - oprand_r
					}
					'*' {
						stack << oprand_l * oprand_r
					}
					'/' {
						if oprand_r == 0 {
							return error('err: divide by zero')
						}
						stack << oprand_l / oprand_r
					}
					else {}
				}
			} else {
				return error('err: invalid expression')
			}
		}
	}
	return stack[0]
}

fn is_num_string(str string) bool {
	for c in str {
		if c !in numeric_char {
			return false
		}
	}
	return true
}

fn memory_bench() ?int {
mut nums := [1, 2, 3]
mut m := map[int]int{} // a map with `string` keys and `int` values


mut memory_bench_var1 := 1
for i := 0; i < 10009; i += 1 {
nums.prepend(i)
rand.shuffle(mut nums)?
nums.prepend(rand.int_in_range(1,100)?)
//nums.prepend(rand.u64_in_range(1,100)?)
m[memory_bench_var1 + i * i] = i
println(i)
}

nums_copy := nums.clone()
println(nums)
println(m)
done_input := os.input('Done')
return 0
}

fn is_digit(ch byte) bool {
	return ch in [`0`,`1`,`2`,`3`,`4`,`5`,`6`,`7`,`8`,`9`]
}

fn is_space(ch byte) bool {
	return ch in [` `, `\t`, `\r`, `\n`]
}

fn main() {

	

//mut file_to_run := ''

mut reg_1 := ''
mut reg_2 := ''
mut reg_3 := ''
mut reg_4 := ''




//time()
//memory_bench()?

//blurb := '"hi"'
//mut re := blurb.replace('"','')
//println(re)


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

mut lines := text.split_into_lines()
//println(lines)
for line in lines {




    if line.starts_with('add:') { //add
	 mut add_bmark := benchmark.new_benchmark() //DEBUG
	 
        //println(line)
		mut add_arg := line.after(':')
		add_bmark.step_message('[DEBUG] add_arg got line after :') //DEBUG
		add_bmark.measure('[DEBUG] add_arg got line after :') //DEBUG
		add_bmark.ok() //DEBUG
		//println(add_arg)
		mut add_num := add_arg.split(',')
		add_bmark.step_message('[DEBUG] add_num split add_arg by ,') //DEBUG
		add_bmark.measure('[DEBUG] add_num split add_arg by ,') //DEBUG
		add_bmark.ok() //DEBUG
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
			add_bmark.step_message('[DEBUG] for adder in add_num loop fineshed') //DEBUG
			add_bmark.measure('[DEBUG] for adder in add_num loop fineshed') //DEBUG
			add_bmark.ok() //DEBUG
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

		add_bmark.step_message('[DEBUG] add: fn fineshed') //DEBUG
		add_bmark.measure('[DEBUG] add: fn fineshed') //DEBUG
		add_bmark.ok() //DEBUG

		
		//println(done_num)
		//println(reg_1)
		//println(reg_2)
		//println(reg_3)
		//println(reg_4)

		add_bmark.stop() //DEBUG
        // call when you want to finalize the benchmark
        println(add_bmark.total_message('[DEBUG] remarks about the add: fn benchmark')) //DEBUG
		

		
    }
	else if line.starts_with('print:') { //print
        ///println(line)
		mut print_arg := line.after(':')
		mut print_arg_byte := print_arg.int()

		if print_arg.contains('"') == true { // if print_arg contains "
		mut print_arg_string := print_arg.replace('"','') // replace " in print_arg
		println(print_arg_string)
		}
		else if print_arg_byte in [`0`,`1`,`2`,`3`,`4`,`5`,`6`,`7`,`8`,`9`] { //print_arg_byte is a number
			//println("print is a num")
			mut print_arg_byte_int := print_arg_byte.str() //Convert print_arg_byte to a string so it can be printed
			println(print_arg_byte_int)
		}
		else {
	match print_arg {
	'reg1' { println(reg_1) }
	'reg2' { println(reg_2) }
	'reg3' { println(reg_3) }
	'reg4' { println(reg_4) }
	else { println(print_arg + " is not a reg number") }
}

		}

//print_arg_byte = ''.bytes().byterune()?

    }
	//Regs CMDS
	else if line.starts_with('reg1:') { //reg1
        ///println(line)
		mut reag1_arg := line.after(':')
		reg_1 = reag1_arg

		//println(print_arg)
		//mut print_string := print_arg.split(',')
		//mut add_num2 := add_num.int()
		//println(add_num)
		
    }
	else if line.starts_with('reg2:') { //reg2
        ///println(line)
		mut reag2_arg := line.after(':')
		reg_2 = reag2_arg

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
	else if line.starts_with('if_equl_exit:') { //if_equl_exit
	 mut if_equl_bmark := benchmark.new_benchmark() //DEBUG
	 
        //println(line)
		mut if_equl_arg := line.after(':')
		if_equl_bmark.step_message('[DEBUG] if_equl_arg got line after :') //DEBUG
		if_equl_bmark.measure('[DEBUG] if_equl_arg got line after :') //DEBUG
		if_equl_bmark.ok() //DEBUG
		//println(add_arg)
		mut if_equl_num := if_equl_arg.split(',')
		if_equl_bmark.step_message('[DEBUG] if_equl_num split if_equl_arg by ,') //DEBUG
		if_equl_bmark.measure('[DEBUG] if_equl_num split if_equl_arg by ,') //DEBUG
		if_equl_bmark.ok() //DEBUG
		//mut add_num2 := add_num.int()
		//println(add_num)
		//mut done_num := '0'

		mut if_equl_is_reg1 := false
		mut if_equl_is_reg2 := false
		mut if_equl_is_reg3 := false
		mut if_equl_is_reg4 := false

		mut loop_count := 0
		mut string_if_value := ''
		mut if_reg := ''

		for if_equl_val in if_equl_num {
			if loop_count == 0 { //loop_count = 0
	         match if_equl_val {
	        'reg1' { if_reg = reg_1 } //Reg1
	        'reg2' { if_reg = reg_2 } //Reg2
	        'reg3' { if_reg = reg_3 } //Reg3
	        'reg4' { if_reg = reg_4 } //Reg4
	        else { println(if_equl_val + " is not a reg number") }
        }
		

			}
			else if loop_count == 1 { //loop_count = 1
			string_if_value = if_equl_val
			
			}
			//TODO add exit code arg


loop_count++
			if_equl_bmark.step_message('[DEBUG] for if_equl_val in if_equl_num loop fineshed') //DEBUG
			if_equl_bmark.measure('[DEBUG] for if_equl_val in if_equl_num loop fineshed') //DEBUG
			if_equl_bmark.ok() //DEBUG
		}
		
if string_if_value == if_reg { //true
exit(0)
}
else if string_if_value != if_reg { //false
	
}

		if_equl_bmark.step_message('[DEBUG] if_equl: fn fineshed') //DEBUG
		if_equl_bmark.measure('[DEBUG] if_equl: fn fineshed') //DEBUG
		if_equl_bmark.ok() //DEBUG

		
		//println(done_num)
		//println(reg_1)
		//println(reg_2)
		//println(reg_3)
		//println(reg_4)

		if_equl_bmark.stop() //DEBUG
        // call when you want to finalize the benchmark
        println(if_equl_bmark.total_message('[DEBUG] remarks about the if_equl: fn benchmark')) //DEBUG
		

		
    }
		else if line.starts_with('math:') { //math
	 mut math_bmark := benchmark.new_benchmark() //DEBUG
	 
        //println(line)
		mut math_arg := line.after(':')
		math_bmark.step_message('[DEBUG] if_equl_arg got line after :') //DEBUG
		math_bmark.measure('[DEBUG] if_equl_arg got line after :') //DEBUG
		math_bmark.ok() //DEBUG
		//println(add_arg)
		mut math_num := math_arg.split(',')
		math_bmark.step_message('[DEBUG] if_equl_num split if_equl_arg by ,') //DEBUG
		math_bmark.measure('[DEBUG] if_equl_num split if_equl_arg by ,') //DEBUG
		math_bmark.ok() //DEBUG
		//mut add_num2 := add_num.int()
		//println(add_num)
		//mut done_num := '0'

		mut if_equl_is_reg1 := false
		mut if_equl_is_reg2 := false
		mut if_equl_is_reg3 := false
		mut if_equl_is_reg4 := false

		mut loop_count := 0
		mut math_value := ''
		mut math_value_reg := ''

		for math_val in math_num {
			if loop_count == 0 { //loop_count = 0
	         match math_val {
	        'reg1' { math_value_reg = 'reg1' } //Reg1
	        'reg2' { math_value_reg = 'reg2' } //Reg2
	        'reg3' { math_value_reg = 'reg3' } //Reg3
	        'reg4' { math_value_reg = 'reg4' } //Reg4
	        else { println(math_val + " is not a reg number") }
        }
		

			}
			else if loop_count == 1 { //loop_count = 1
			math_value = math_val

			
			}
			


loop_count++
			math_bmark.step_message('[DEBUG] for if_equl_val in if_equl_num loop fineshed') //DEBUG
			math_bmark.measure('[DEBUG] for if_equl_val in if_equl_num loop fineshed') //DEBUG
			math_bmark.ok() //DEBUG
		}
		mut math_value2 := math_value.trim_space()
		rev_pol := expr_to_rev_pol(math_value2) or {panic(err)}
		res := eval_rev_pol(rev_pol) or {panic(err)}
		//println(res)
		match math_value_reg {
			'reg1' { reg_1 = res.str() } //Reg1
	        'reg2' { reg_2 = res.str() } //Reg2
	        'reg3' { reg_3 = res.str() } //Reg3
	        'reg4' { reg_4 = res.str() } //Reg4
	        else { println(math_value_reg + " is not a reg number") }
		}


		math_bmark.step_message('[DEBUG] if_equl: fn fineshed') //DEBUG
		math_bmark.measure('[DEBUG] if_equl: fn fineshed') //DEBUG
		math_bmark.ok() //DEBUG

		
		//println(done_num)
		//println(reg_1)
		//println(reg_2)
		//println(reg_3)
		//println(reg_4)

		math_bmark.stop() //DEBUG
        // call when you want to finalize the benchmark
        println(math_bmark.total_message('[DEBUG] remarks about the if_equl: fn benchmark')) //DEBUG
		

		
    }


}

if debug_mode == true {
println('[DEBUG] compile took: ${sw.elapsed().seconds()}seconds')
}
else if debug_mode == false {

}

}