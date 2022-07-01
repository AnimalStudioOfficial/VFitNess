import os
import os.cmdline
import crypto.rand
import strings

import encoding.base58
import encoding.base64
import encoding.hex
import encoding.utf8
import crypto.md5
import compress

fn gen(to string) ?int {
	mut setup_gen_part1 := to.bytes()
	mut setup_gen_part2 := hex.encode(setup_gen_part1)
	mut setup_gen_part3 := utf8.reverse(setup_gen_part2)
mut gen1 := base58.encode(setup_gen_part3)
mut stringto := gen1.bytes()
mut gen2 := base64.encode(stringto).bytes()
mut gen3 := hex.encode(gen2).bytes()
mut gen4 := base64.encode(gen3).bytes()
mut gen5 := gen4.str()
mut gen6 := md5.hexhash(gen5).bytes()
mut gen7 := base64.encode(gen6).bytes()
mut gen8 := gen7.str()
println(gen8)
return 0
}

fn main() {
	blocksize := 256
	size := cmdline.option(os.args, '-size', '80').int()
	repeats := cmdline.option(os.args, '-repeats', '4').int()
	for _ in 0 .. repeats {
		mut sb := strings.new_builder(blocksize)
		for {
			x := rand.read(blocksize)?
			for c in x {
				if c >= `0` && c <= `~` {
					sb.write_u8(c)
				}
			}
			if sb.len > size {
				//println(sb.str()[0..size])
				
				break
			}
		}
	}
gen("hi")?
}