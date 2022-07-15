import os
import rand

//b := ['1', '2', '3', '4', '5', '6', '7', '8', '9']
//mut brand := b[ rand.intn(b.len)? ]

//a := ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
//mut arand := a[ rand.intn(a.len)? ]
//return arand

[manualfree]
fn gen() ?string {
r:=['1','2']
mut o:=r[rand.intn(r.len)?]
match o {
'1' { //char
a := ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
mut ar := a[rand.intn(a.len)?]
return ar
}
'2' { //num
b := ['1','2','3','4','5','6','7','8','9']
mut br := b[rand.intn(b.len)?]
return br
}
else{}
}
return ''
}

[manualfree]
fn gen_l() ?string {
a := ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
mut ar := a[rand.intn(a.len)?]
return ar
}

[manualfree]
fn gen_n() ?string {
b := ['1','2','3','4','5','6','7','8','9']
mut br := b[rand.intn(b.len)?]
return br
}

fn main2() ?int {
mut trys:=0
mut pass:=[]string{}
//mut u2_b := ''
//mut u3_b := ''
u1:=os.input('password:')
u2:=os.input('does the password have letters:')
u3:=os.input('does the password have nums:')
try2:
pass.prepend(gen_l()?)	
pass.prepend(gen_l()?)	
pass.prepend(gen_l()?)	
pass.prepend(gen_l()?)	
pass.prepend(gen_l()?)	
pass.prepend(gen_l()?)	
pass.prepend(gen_l()?)	
pass.prepend(gen_l()?)	
mut fin := pass.join('')
if fin==u1{
println('done with '+trys.str())
}else{
trys++
pass.clear()
unsafe{goto try2}
}
return 0
}

[manualfree]
fn main() {
//main2()?
u:=os.input('password')
mut trys:=0
mut pass:=[]string{}
try:
for i:=0;i<8;i++{
//Gen random pass
pass.prepend(gen()?)	
}
mut fin := pass.join('')
if fin==u{
println('done with '+trys.str())
}else{
trys++
pass.clear()
unsafe{goto try}
}
//println(pass.join(''))
}
