import os

fn main(){
println("Welcome to Sorter")

 files := os.ls('tosort')?
 mut count := 0
 if files.len > 0 {
     for file in files {
         if file.ends_with('.v') {
             os.mv(file, 'build/') or {
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