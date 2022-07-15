module main

import os
import math
import rand

import serkonda7.termtable as tt

fn assistant_open() ?int {
open_user_input := os.input('What do you want me to Open (e.g. say link,cmd):').to_lower()
match open_user_input {
	'link' { //Link
	open_link_user_input := os.input('What link do you want me to open:')
	os.open_uri(open_link_user_input) or{panic(err)} //Open link
	}
	'cmd' { //Cmd
		open_cmd_user_input := os.input('What cmd do you want me to open:').to_lower()
	match open_cmd_user_input {
    'food' { food(.return_error) or{panic(err)} }
	'user' { user() or{panic(err)} }
	'assistant' { assistant_cmd() or{panic(err)} }
	'activity' { activity() or{panic(err)} }
	'weight' { weight_cmd() or{panic(err)} }
	'settings' { settings(.return_error)? }
    'info' { pc_info() }
    'best' { best_cmd() or{panic(err)} }
    'about' { about_cmd() }
	'quit' { exit(0) }
	else { println(open_cmd_user_input+" is NOT a command") }
}

	}
	else{
		println(open_user_input+' is NOT a cmd!')
		return 1
	}
}

return 0
}

fn assistant_help() {
data := [
		['Number', 'Name', 'Dec'],
		['1', 'open', 'open a link or cmd'],
		['2', 'help', 'Show this Menu'],
		['3', 'math', ''],
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


fn assistant_math_calculator() ?int {
	println('Please enter the expression you want to calculate, e.g. 1e2+(3-2.5)*6/1.5 .')
	println("Enter 'exit' or 'EXIT' to quit.")
	mut expr_count := 0
	for {
		expr_count++
		expr := os.input_opt('[$expr_count] ') or {
			println('')
			break
		}.trim_space()
		if expr in ['exit', 'EXIT'] {
			break
		}
		rev_pol := expr_to_rev_pol(expr) or {
			eprintln(err)
			continue
		}
		res := eval_rev_pol(rev_pol) or {
			eprintln(err)
			continue
		}
		println(res)
	}

return 0
}

fn assistant_math_pow() {
math_power1_input := os.input('Enter the number to be powered:').int()
math_power2_input := os.input('Enter the power:').int()
mut math_power_number := math.powf(math_power1_input,math_power2_input)
println(math_power_number)
}

fn assistant_math_round() {
math_round1_input := os.input('Enter the number to be Rounded:').int()
mut math_round_number := math.round(math_round1_input)
println(math_round_number)
}

fn assistant_math() {
math_user_input := os.input('What do you want to do:').to_lower()
match math_user_input {
	'calculator' {assistant_math_calculator() or{panic(err)}}
	'cal' {assistant_math_calculator() or{panic(err)}}

	'pow' {assistant_math_pow()}
	'power' {assistant_math_pow()}

	'round' {assistant_math_round()}
	else {println(math_user_input+' is NOT a option!')}
}
}

fn assistant_games_guss() ?int {
mut trys := 0
mut wrong_numbers := []int{}

println('Welcome to Guss the Number')
println('pick a number in a rage 1-8')
println('the comeputer will try to guss the number say y if currect and n if wrong')
computer_pick:
mut picked_num := rand.int_in_range(1,8)?
if wrong_numbers.contains(picked_num) == true {
 unsafe{goto computer_pick}
}
println(picked_num)

right_user_input := os.input('say y if currect and n if wrong').to_lower()
if right_user_input == 'y' { //currect
 println('Computer won in '+trys.str()+' Trys!')
} else if right_user_input == 'n' { //wrong
 trys++
 wrong_numbers.prepend(picked_num)
 unsafe{goto computer_pick}
}
return 0
}

fn assistant_games() {
games_user_input := os.input('What game do you want to play:').to_lower()
match games_user_input {
	'guss' {assistant_games_guss() or{panic(err)}}
	else {println(games_user_input+' is NOT a option!')}
}
}

fn assistant_cmd() ?int {
println('Hello My Name Is Zack And I Am Your Personal Assistant!')
println('-------------------------------------------------------')
// read text from stdin
user_input := os.input('What do you want me to do:').to_lower()

if user_input == 'open' { //Open
assistant_open() or{panic(err)}
} else if user_input == 'help' { //Help
assistant_help()
} else if user_input == 'math' { //Math
assistant_math()
} else if user_input == 'games' { //Games
assistant_games()
}


return 0
}