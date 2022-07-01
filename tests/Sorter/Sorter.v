import os
import os.cmdline
import crypto.rand
import strings

import encoding.base58
import encoding.base64
import encoding.hex
import encoding.utf8

fn gen(to string) {
	mut setup_gen_part1
	mut setup_gen_part2 := hex.encode(to)
mut gen1 := base58.encode(to)
mut stringto := gen1.bytes()
mut gen2 := base64.encode(stringto).bytes()
mut gen3 := hex.encode(gen2)
mut gen4 := 
println(gen3)
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
gen("hi")
}