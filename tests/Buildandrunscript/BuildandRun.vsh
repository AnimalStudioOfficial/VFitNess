const (
        exe_file  = ''
        build_cmd = ''
)

// print command then execute it
fn sh(cmd string) {
        println('❯ $cmd')
        print(execute_or_exit(cmd).output)
}

doesexist := exists('build')
if doesexist == true && doesexist != false { // true
        println(doesexist)
} else if doesexist == false && doesexist != true { // false
        println(doesexist)
        mkdir('build')?
}
