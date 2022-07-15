module main

import os

import serkonda7.termtable as tt

fn vanilla_ice_cream_breyers_1() ?int {
	println('Serving Size: 2/3 cup')
data := [
		['Name', 'Amount', 'Daily Value'],
		['Calories', '170', ''],
		['Total Fat', '9g', '14%'], //Total Fat
		['Cholesterol', '25mg', '8%'],
		['Sodium', '50mg', '2%'],
		['Total Carbohydrate', '19g', '6%'],
		['Total Sugars', '19g', ''],
		['Protein', '3g', ''],
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

return 0
}


fn search_vanilla_ice_cream() ?int { //vanilla ice cream
data := [
		['Number', 'Brand', 'Name', 'Dec'],
		['1', 'Breyers', 'Natural Vanilla Ice Cream', ''],
		['2', '', '', ''],
		['3', '', '', ''],
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
	
search_1_user_input := os.input('What do you want to See (Say 1,2 or 3):')
match search_1_user_input {
	'1' {vanilla_ice_cream_breyers_1()?}
	'2' {}
	'3' {}
	else {println(search_1_user_input+' is NOT a option!')}
}
return 0
}


fn search_food() ?int {
search_food_user_input := os.input('What do you want to Search:').to_lower()
match search_food_user_input {
	'vanilla ice cream' {search_vanilla_ice_cream() or{panic(err)}}
	'' {}
	else {

	}
}

return 0
}