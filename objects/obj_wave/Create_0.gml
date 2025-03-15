
lateral_init()

xspd = spd*dcos(image_angle);
yspd = -spd*dsin(image_angle);

fcos = dcos(image_angle);
fsin = dsin(image_angle);

width = abs(sprite_width*fcos) + abs(sprite_height*fsin)
height = abs(sprite_width*fsin) + abs(sprite_height*fcos)

growth = spd/64

image_blend = C_WHITE
c_trail = C_PINK

image_xscale = scale;
image_yscale = scale;

sprite_index = front
