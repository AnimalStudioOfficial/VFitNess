import os
import net.http
import serkonda7.termtable as tt

// mut s := http.get("https://github.com/vlang/v/releases/download/0.3/v_windows.zip")?
// os.write_file('test.zip', s.body) or {println(err)}

fn uninstall() ?int {
	
return 0
}

fn install() ?int {
os.execute_or_panic('cd C:')
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
