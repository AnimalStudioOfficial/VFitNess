import os

fn main(){
println("Welcome to Sorter")

 files := os.ls('tosort')?
 mut count := 0
 if files.len > 0 {
     for file in files {
         if file.ends_with('.v') {
             os.mv(file, 'tosort/v') or {
                println('err: $err')
                
              }
         }
		if file.ends_with('.png') {
             os.mv(file, 'tosort/png') or {
                println('err: $err')
                
              }
         }
         count++
     }
 }
 if count == 0 {
     println('No files')
 }
}