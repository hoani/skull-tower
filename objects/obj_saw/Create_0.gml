
lateral_init()

xspd = spd*dcos(image_angle);
yspd = -spd*dsin(image_angle);

w_2 = 4;

xfloor = (w_2 + 1) * dcos(image_angle) + dsin(image_angle);
yfloor = (w_2 + 1) * dsin(image_angle) - dcos(image_angle);




