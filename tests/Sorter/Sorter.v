import os

fn start() ?int {
files := os.ls('tosort')?
 mut count := 0
 if files.len > 0 {
     for file in files {
         if file.ends_with('.v') {
             os.mv(file, 'tosort/v/')?
         }
		else if file.ends_with('.png') {
             os.mv(file, 'png')?
			
         }
         count++
     }
 }
 if count == 0 {
     println('No files')
 }
	return 0
}

fn main(){
println("Welcome to Sorter")

result := os.execute('sh mv *.png tosort/v')
if result.exit_code != 0 {
	println(result.output)
}
 //start()?
}