step+=global.s;

x += xspd*global.s
y += yspd*global.s

if step > SHADOW_FRAMES {
    instance_destroy()
}
