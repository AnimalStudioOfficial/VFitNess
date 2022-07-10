import os
import net.http
import szip

import serkonda7.termtable as tt

// mut s := http.get("https://github.com/vlang/v/releases/download/0.3/v_windows.zip")?
// os.write_file('test.zip', s.body) or {println(err)}


fn get_site(site string) string {
	res := http.get(site) or { return '$site: "Is down"' }
	return '$site: $res.status_msg'
}

fn uninstall() ?int {
	
return 0
}

fn install() ?int {
	mut result :=''
	websites := ["https://youtube.com/","https://github.com/","https://google.com"]
	
	for site in websites {
		result += get_site(site) + '\n'
	}
	println(result)

os.mkdir("temp")?
os.chdir("temp")?

mut f := os.create('temp/fit.zip')?


 mut s := http.get("https://github.com/AnimalStudioOfficial/VFitNess/releases/download/0.4/Src.exe")?
 os.write_file('temp/fit.zip', s.body) or {println(err)}

return 0
}

fn update() ?int {
	
return 0
}

fn main() {
        println('Welcome to the VFitNess Setup')
        println('-----------------------------')
        data := [
                ['Number', 'Name', 'Dec'],
                ['1', 'install', 'Download and install VFitNess'],
                ['2', 'uninstall', 'Uninstall VFitNess'],
                ['3', 'update', 'Update VFitNess'],
                ['4', 'quit', 'Quit the setup'],
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

        // read text from stdin
        user_input := os.input('What do you want to do:').to_lower()
        match user_input {
                'install' { install() or {println(err)} }
                'uninstall' { uninstall() or {println(err)} }
                'update' { update() or {println(err)} }
                'quit' { exit(0) }
                else { println(user_input + ' is NOT a command') }
        }
}
