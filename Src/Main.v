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
//import benchmark
//import v.vcache
import clipboard
//import net.http
import json
import encoding.base58
import encoding.base64
//import crypto.md5
//import crypto.sha512


//import encoding.hex

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
	version = "0.04"
)

struct User {
  	name   string
	age    string
	gender    string
}


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



fn about_cmd() {
        term.clear() // clears the content in the terminal
        println('VFitNess ' + version)
        println('------------------')
        println('By AnimalStudioOfficial')
        println('Made with Vlang')
}

fn encript(stringtoencript string) {
	if typeof(stringtoencript).name == "string" {
mut stringtoencript_base58 := base58.encode(stringtoencript)
mut stringtoencript_base64 := base64.encode_str(stringtoencript_base58)
	}

}

fn help_cmd() {
data := [
		['Number', 'Name', 'Dec'],
		['1', 'food', 'food tracking'],
		['2', 'about', 'VFitNess about'],
		['3', 'quit', 'exit the app'],
        ['4', 'info', 'pc info'],
		['5', 'best', 'best food ideas'],
		['6', 'settings', 'settings'],
		['7', 'user', 'Your User Profile'],
		['8', 'weight', 'weight tracking'],
		['9', 'activity', 'your activity'],
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
//calories
fn add_calories_file_input(s State) ?int {
 add_calories_file_input := os.input('Do you want to create the calories.txt file:').to_lower()
if add_calories_file_input == 'yes' || add_calories_file_input == 'y' {
mut f := os.create('data/calories.txt')?
return f.writeln('0')
}
else if add_calories_file_input == 'no' || add_calories_file_input == 'n' {
exit(1)
}
 return 0
}

fn food(s State) ?int {
  
//Stats
 mut calories := ""
 mut fat := "g" //Add g to the end of the string to repesent grams
 mut proteins := "g" //Add g to the end of the string to repesent grams

//Read Stats files
//Fat file
check_fat_file:
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
    unsafe {goto check_proteins_file}
    exit(1)
}
//proteins file
check_proteins_file:
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
    unsafe {goto check_fat_file}
    exit(1)
}
//calories file
check_calories_file:
mut is_calories_file := os.is_file("data/calories.txt")
if is_calories_file == true && is_calories_file != false{
   // println("true")
    //TODO add check is_readable() fn to calories file

    data := os.read_file("data/calories.txt")?
    calories = data
  //println(data)


 //println(calories)
}
else if is_calories_file == false && is_calories_file != true{
    //println("false")
    println(chalk.fg(chalk.style('[ERROR]', 'bold'), 'red')+' calories.txt is not a file or does not exist')

    n := add_calories_file_input(.return_error) or {
		println('Error: $err')
		0
	}
	println('$n bytes written')
    unsafe {goto check_fat_file}
    exit(1)
}



start:
//TODO add help menu to food
    println("Welcome To Food")
    food_user_input := os.input('What do you want to do:')
 match food_user_input {
    'stats' { goto stats }
    'add' { unsafe {goto food_add}}
	'clear' { unsafe {goto food_clear}}
    'about' { about_cmd() }
	'quit' { exit(0) }
	else { println(food_user_input+" is NOT a command") }
 }
food_add:
 food_add_calories_user_input := os.input('What do you want to add to calories:').int() //calories input
 mut caloriestemp := calories.int() //Convert calories to a int
 mut ler := caloriestemp + food_add_calories_user_input //add calories int and food_add_calories_user_input
 mut ker := ler.str() //then convert back to string
 //println(ker)
calories = ker 

 food_add_fat_user_input := os.input('What do you want to add to Fat:').int() //Fat input
 mut fattemp := fat.int() //Convert fat to a int
 mut ger := fattemp + food_add_fat_user_input //add fat int and food_add_fat_user_input
 mut her := ger.str() //then convert back to string
 //println(her)
fat = her + 'g' //Add g to the end of the string to repesent grams

food_add_proteins_user_input := os.input('What do you want to add to proteins:').int() //proteins input
 mut proteinstemp := proteins.int() //Convert proteins to a int
 mut jer := proteinstemp + food_add_proteins_user_input  //add proteins int and food_add_proteins_user_input
 mut ter := jer.str() //then convert back to string
  //println(ter)
proteins = ter + 'g' //Add g to the end of the string to repesent grams

goto write_stats_to_file
goto start
stats:
//calories
 println("calories:"+calories)
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
 //calories file
 mut calories_p := os.create('data/calories.txt')?
 defer {
 calories_p.close()
 }
 calories_p.writeln(calories)?
 goto start
food_clear:
 fat = "g"
 calories = ""
 proteins = "g"
 goto write_stats_to_file
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
best_protein_1_data := [
		['Number', 'Name', 'dec'],
		['1', 'Eggs', 'Whole eggs are among the most nutritious foods available.'],
		['2', 'Almonds', 'Almonds are a nutritious tree nut rich in essential nutrients like fiber, vitamin E, manganese, and magnesium'],
		['3', 'Chicken breast', ''],
        ['4', 'Cottage cheese', 'Cottage cheese is a type of cheese that is low in fat and calories, yet high in protein.'],
        ['5', 'Greek yogurt', 'Greek yogurt, also called strained yogurt, is a very thick type of yogurt that’s high in protein.'],
        ['6', 'Milk', 'Dairy milk contains a little of nearly every nutrient that your body needs.'],
        ['7', 'Lentils', ''],
        ['8', 'Lean beef', ''],
        ['9', 'Fish', ''],
        ['10', 'Quinoa', ''],
        ['11', 'Protein powders', ''],
        ['12', 'Ezekiel bread', 'Ezekiel bread is different from most other breads.'],
        ['13', 'Pumpkin seeds', 'Pumpkin seeds are incredibly delicious and highly nutritious.'],
        ['14', 'Turkey breast', 'Turkey breast is similar to chicken breast in many ways.'],
        ['15', 'Shellfish', 'Shellfish, including shrimp, oysters, clams, and scallops are excellent sources of protein.'],
        ['16', 'Peanuts and peanut butter', 'Although people commonly think of peanuts as nuts, they’re actually legumes.'],



	]
	t2 := tt.Table{
		data: best_protein_1_data
		// The following settings are optional and have these defaults:
		style: .fancy_grid
		header_style: .bold
		align: .left
		orientation: .row
		padding: 1
		tabsize: 4
	}
	println(t2)
}

fn best_fat() {
println("Here are some results:")
best_fat_data := [
		['Number', 'Name'],
		['1', '9 High-Fat Foods That Offer Great Health Benefits'],
		['2', '18 of the Best Foods for Your Healthy Weight Journey'],
		['3', 'soon'],
        ['4', 'soon'],
	]
	t := tt.Table{
		data: best_fat_data
		// The following settings are optional and have these defaults:
		style: .fancy_grid
		header_style: .bold
		align: .left
		orientation: .row
		padding: 1
		tabsize: 4
	}
	println(t)

best_fat_user_input := os.input('What do you want to Look for:').to_lower()
match best_fat_user_input {
    '1' { goto num1 }
    '2' { goto num2 }
    'about' { about_cmd() }
	'quit' { exit(0) }
	else { println(best_fat_user_input+" is NOT a command") }
}
//Number 1
num1:
best_fat_1_data := [
		['Number', 'Name', 'dec'],
		['1', 'Avocados', ''],
		['2', 'Cheese', 'Cheese is surprisingly nutritious, despite its iffy reputation.'],
		['3', 'Dark chocolate', ''],
        ['4', 'Whole eggs', ''],
        ['5', 'Fatty fish', ''],
        ['6', 'Nuts', ''],
        ['7', 'Chia seeds', ''],
        ['8', 'Extra virgin olive oil', ''],
        ['9', 'Full-fat yogurt', ''],
        ['10', 'soon', 'soon'],
        ['11', 'soon', 'soon'],
        ['12', 'soon', 'soon'],
        ['13', 'soon', 'soon'],
        ['14', 'soon', 'soon'],
        ['15', 'soon', 'soon'],
        ['16', 'soon', 'soon'],
	]
	t2 := tt.Table{
		data: best_fat_1_data
		// The following settings are optional and have these defaults:
		style: .fancy_grid
		header_style: .bold
		align: .left
		orientation: .row
		padding: 1
		tabsize: 4
	}
	println(t2)
//Number 2
num2:
best_fat_2_data := [
		['Number', 'Name', 'dec'],
		['1', 'Whole eggs', ''],
		['2', 'Leafy greens', 'Leafy greens include kale, spinach, collard greens, Swiss chard, and a few others.'],
		['3', 'Salmon', 'Fatty fish like salmon are incredibly nutritious and very satisfying.'],
        ['4', 'Cruciferous vegetables', 'Cruciferous vegetables include broccoli, cauliflower, cabbage, and Brussels sprouts.'],
        ['5', 'Chicken breast and some lean meats', ''],
        ['6', 'Potatoes and other root vegetables', ''],
        ['7', 'Tuna', 'Tuna is another satiating high protein food.'],
        ['8', 'Beans and legumes', ''],
        ['9', 'Soups', ''],
        ['10', 'Cottage cheese', 'Dairy products tend to be high in protein.'],
        ['11', 'Avocados', ''],
        ['12', 'Nuts', ''],
        ['13', 'Whole grains', 'Recent studies show that a diet rich in whole grains can help support healthy weight loss '],
        ['14', 'Chili pepper', 'Eating chili peppers may be useful on a weight loss diet.'],
        ['15', 'Fruit', 'Most health experts agree that fruit is healthy.'],
        ['16', 'soon', 'soon'],

	]
	t3 := tt.Table{
		data: best_fat_2_data
		// The following settings are optional and have these defaults:
		style: .fancy_grid
		header_style: .bold
		align: .left
		orientation: .row
		padding: 1
		tabsize: 4
	}
	println(t3)
}


fn best_cmd() ?int {
	data := [
		['Number', 'Name', 'Dec'],
		['1', 'protein', 'best protein foods'],
		['2', 'fat', 'best fat foods'],
		['3', 'about', 'VFitNess about'],
		['4', 'quit', 'exit the app'],
       

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
best_user_input := os.input('What do you want to Look for:').to_lower()
match best_user_input {
    'protein' { best_protein() }
    'fat' { best_fat() }
    'about' { about_cmd() }
	'quit' { exit(0) }
	else { println(best_user_input+" is NOT a command") }
}
return 0
}

//Settings
fn cleardata(s State) ?int {
if os.exists("data/fat.txt") == true { //Fat file
 os.rm("data/fat.txt") or {panic(err)}
}
else if  os.exists("data/fat.txt") == false { //Fat file does NOT exist
println("[INFO] data/fat.txt does not exist")
}

if os.exists("data/proteins.txt") == true { //proteins file
 os.rm("data/proteins.txt") or {panic(err)}
}
else if  os.exists("data/proteins.txt") == false {
println("[INFO] data/proteins.txt does not exist")
}

if os.exists("data/calories.txt") == true { //calories file
 os.rm("data/calories.txt") or {panic(err)}
}
else if  os.exists("data/calories.txt") == false { //calories file does NOT exist
println("[INFO] data/calories.txt does not exist")
}
 
if os.exists("data/user.txt") == true { //user file
 os.rm("data/user.txt") or {panic(err)}
}
else if  os.exists("data/user.txt") == false { //user file does NOT exist
println("[INFO] data/user.txt does not exist")
}
 return 0
}


fn settings(s State) ?int {
settings_data := [
		['Number', 'Name', 'Dec'],
		//['1', 'clear', 'Clear before cmd'], //TODO add Clear before cmd
		['1', 'cleardata', 'Clear user data (e.g. food tracking data, weight tracking data, user data)'],
		['3', 'soon', 'soon'], //TODO add more settings
        ['4', 'soon', 'soon'], //TODO add more settings
		['5', 'soon', 'soon'], //TODO add more settings
	]
	t := tt.Table{
		data: settings_data
		// The following settings are optional and have these defaults:
		style: .fancy_grid
		header_style: .bold
		align: .left
		orientation: .row
		padding: 1
		tabsize: 4
	}
	println(t)
	settings_user_input := os.input('What do you want to change:').to_lower()

	match settings_user_input {
	'cleardata' { cleardata(.return_error)? }
	'quit' { exit(0) }
	else { println(settings_user_input+" is NOT a command") }
}
return 0
}

fn user_new() ?int {
//mut user_name := ''
//mut user_age := 0

user_name_input := os.input('What is your Name:')
user_age_input := os.input('What is your age:')
user_gender_input := os.input('What is your gender:')

mut usr := User{
  	name: user_name_input
	age: user_age_input
	gender: user_gender_input
	}
out := json.encode(usr)
println(out)

 mut outfile := os.create('data/user.txt')?
 defer {
 outfile.close()
 }
 outfile.writeln(out)?
return 0
}

fn user_pro() ?int {
	if os.exists("data/user.txt") == true {

	
	user_data := os.read_file("data/user.txt")?
	//println(user_data)
    u := json.decode(User, user_data)?
	//println(u)

	//println('Your Profile')
	data := [
		["Your Profile"],
		["Name: "+u.name],
		["Age: "+u.age],
		["Gender: "+u.gender],

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
	//println(u.age)
}
else if os.exists("data/user.txt") == false {
	println(chalk.fg(chalk.style('[ERROR]', 'bold'), 'red')+' user.txt is not a file or does not exist')
	println("pls main menu and type user and then type new to create a Profile")
	time.sleep(3)
}
return 0
}

fn user() ?int {
	println("Welcome to user")
		data := [
		['Number', 'Name', 'Dec'],
		['1', 'new', 'New profile'],
		['2', 'user', 'Your User Profile'],
		['3', 'about', 'VFitNess about'],
		['4', 'quit', 'exit the app'],
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
	
user_cmd_user_input := os.input('What do you want to do:').to_lower()
match user_cmd_user_input {
	'new' { user_new()? }
	'user' { user_pro()? }
    'about' { about_cmd() }
	'quit' { exit(0) }
	else { println(user_cmd_user_input+" is NOT a command") }
}
return 0
}


fn add_weight_file_input(s State) ?int {
 add_weight_file_input := os.input('Do you want to create the weight.txt file:').to_lower()
if add_weight_file_input == 'yes' || add_weight_file_input == 'y' { 
mut f := os.create('data/weight.txt')?
return f.writeln('0lb')
}
else if add_weight_file_input == 'no' || add_weight_file_input == 'n' {
exit(1)
}
 return 0
}

fn weight_cmd() ?int {

//Stats
 mut weight := "lb" //Add lb to the end of the string to repesent pounds


//Read Stats files
//weight file
check_weight_file:
mut is_weight_file := os.is_file("data/weight.txt")
if is_weight_file == true && is_weight_file != false{
   // println("true")
    //TODO add check is_readable() fn to weight file

    data := os.read_file("data/weight.txt")?
    weight = data
  //println(data)


 //println(weight)
}
else if is_weight_file == false && is_weight_file != true{
    //println("false")
    println(chalk.fg(chalk.style('[ERROR]', 'bold'), 'red')+' weight.txt is not a file or does not exist')

    n := add_weight_file_input(.return_error) or {
		println('Error: $err')
		0
	}
	println('$n bytes written')
    
    exit(1)
}

weight_cmd_start:
//TODO add help menu to weight
    println("Welcome To Weight")
    weight_user_input := os.input('What do you want to do:')
 match weight_user_input {
    'stats' { unsafe{goto weight_stats} }
    'add' {unsafe{goto weight_add} }
    'about' { about_cmd() }
	'quit' { exit(0) }
	else { println(weight_user_input+" is NOT a command") }
 }

 weight_add:
 weight_add_weight_user_input := os.input('What do you want to add to weight:').int() //weight input
 mut weighttemp := weight.int() //Convert weight to a int
 mut jer := weighttemp + weight_add_weight_user_input //add weight int and weight_add_weight_user_input
 mut ter := jer.str() //then convert back to string
 //println(her)
weight = ter + 'lb' //Add lb to the end of the string to repesent pounds


goto weight_write_stats_to_file
goto weight_cmd_start
weight_stats:
//weight
 println("weight: "+weight)
 goto weight_cmd_start
weight_write_stats_to_file:
//weight file
 mut weight_f := os.create('data/weight.txt')?
 defer {
 weight_f.close()
 }
 weight_f.writeln(weight)?

 goto weight_cmd_start
 return 0
}

//	int_var := 3
//	str_var := 'Z'
//	bool_var := false	
//	println(typeof(int_var).name + '\n' + typeof(str_var).name + '\n' + typeof(bool_var).name)

//struct Employee {
//   name  bool
//}

// x := Employee{true}
// println(x.name)


fn steps() {
//TODO add the steps cmd to keep track of the users steps
}

struct Activity_stats {
mut:
  	date   string //Date of Activity
	steps    string //Steps
	cals    string //calories burnt
	mi    string //Miles
	bpm_max    string //Max BPM
	bpm_avg    string
}

fn activity_new() ?int {

mut date_activity := time.now().str() //Get the time now

steps_user_input := os.input('Please enter your Steps:') //Input Steps
calories_user_input := os.input('Please enter your Calories Burnt:') //Input Calories Burnt
miles_user_input := os.input('Please enter your Miles:') //Input Miles
bpm_max_user_input := os.input('Please enter your bpm max:') //Input bpm max
bpm_avg_user_input := os.input('Please enter your bpm avg:') //Input bpm avg

mut a_s := Activity_stats{
  	date: date_activity //Date of Activity
	steps: steps_user_input //Steps
	cals: calories_user_input //calories burnt
	mi: miles_user_input //Miles
	bpm_max: bpm_max_user_input //Max BPM
	bpm_avg: bpm_avg_user_input

	}
out := json.encode(a_s)
println(out)
file_name_user_input := os.input('Please enter your activity file name:') //Input activity file name

 mut outfile := os.create('data/'+file_name_user_input+'.txt') or {panic(err)}
 defer {
 outfile.close()
 }
 outfile.writeln(out) or {panic(err)}
return 0
}

fn activity_read() ?int {
start:
file_to_read_user_input := os.input('Please enter the file you want to read:')
mut is_a_file := os.is_file("data/"+file_to_read_user_input+".txt")
match is_a_file {
	true { //file_to_read_user_input is a file
	mut is_file_readable := os.is_readable("data/"+file_to_read_user_input+".txt") // is file readable
	match is_file_readable {
		true {
	user_activity_data := os.read_file("data/"+file_to_read_user_input+".txt")?
	
    u := json.decode(Activity_stats, user_activity_data)?
	

	
	data := [
		["Your Activity"],
		["Date: "+u.date],
		["Steps: "+u.steps],
		["Calories Burnt: "+u.cals],
		["Miles: "+u.mi],
		["Bpm Max: "+u.bpm_max],
		["Bpm Avg: "+u.bpm_avg],

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
		false {
	println(file_to_read_user_input+' is NOT readable file or is set to read only')
		retry_start2:
		retry2_user_input := os.input('Do you want to try a different file:').to_lower()
		if retry2_user_input == 'y' || retry2_user_input == 'yes' {
			unsafe{goto start}
		}
		else if retry2_user_input == 'n' || retry2_user_input == 'no' {
			println('Ok exiting')
			exit(0)
		}
		else {
			println(retry2_user_input+' is NOT a cmd. Please enter yes or no!')
			unsafe{goto retry_start2}
		}
		}
	}

	}
	false { //file_to_read_user_input is not a file
		println(file_to_read_user_input+' is a invalid file')
		retry_start:
		retry_user_input := os.input('Do you want to try again:').to_lower()
		if retry_user_input == 'y' || retry_user_input == 'yes' {
			unsafe{goto start}
		}
		else if retry_user_input == 'n' || retry_user_input == 'no' {
			println('Ok exiting')
			exit(0)
		}
		else {
			println(retry_user_input+' is not a cmd. Please enter yes or no!')
			unsafe{goto retry_start}
		}

	}
}


return 0
}


fn activity() ?int {
	//TODO add help menu to activity
println("Welcome To Cctivity")
    activity_user_input := os.input('What do you want to do:').to_lower()
 match activity_user_input {
    'read' { activity_read() or{panic(err)} }
    'new' { activity_new() or{panic(err)} }
    'about' { about_cmd() }
	'quit' { exit(0) }
	else { println(activity_user_input+" is NOT a command") }
 }
return 0
}

fn main(){

mut data_dir_exists := os.exists("data") //Check if data dir exists
if data_dir_exists == true && data_dir_exists != false { //data dir exists
//println("[DEBUG] data dir exists: true")

}
else if data_dir_exists == false && data_dir_exists != true { //data dir does NOT exist
    //println("[DEBUG] data dir exists: false")
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
	'user' { user()? }
	'activity' { activity()? }
	'weight' { weight_cmd()? }
	'settings' { settings(.return_error)? }
    'info' { pc_info() }
    'best' { best_cmd()? }
    'about' { about_cmd() }
	'quit' { exit(0) }
	else { println(user_input+" is NOT a command") }
}

}