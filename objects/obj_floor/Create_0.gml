w = sprite_get_width(sprite_index)*image_xscale;
h = sprite_get_height(sprite_index)*image_yscale;

vcosc = dcos(image_angle);
vsinc = dsin(image_angle);

wc = w;
hc = h;

slope_angle = image_angle;

if slope_angle > 90 {
    slope_angle -= 360;
}

while slope_angle < 0 {
    slope_angle += 90
    var wp = w;
    var hp = h;
    w = hp;
    h = wp;
}

vcos = dcos(slope_angle);
vsin = dsin(slope_angle);

xc = x + (vcosc*wc + vsinc*hc)/2;
yc = y + (-vsinc*wc + vcosc*hc)/2;

x0 = xc - (vcos*w + vsin*h)/2;
y0 = yc - (-vsin*w + vcos*h)/2;

x1 = xc + (vcos*w - vsin*h)/2;
y1 = yc - (vsin*w + vcos*h)/2;

x2 = xc + (vcos*w + vsin*h)/2;
y2 = yc + (-vsin*w + vcos*h)/2;

x3 = xc + (-vcos*w + vsin*h)/2;
y3 = yc - (-vsin*w - vcos*h)/2;

