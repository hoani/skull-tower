

cmds = commands_init()
commands_register_single_player(cmds)

// frame objects
f = {
    hang: noone,
    floor: {
        inst: noone,
        slope: 0,
        scos: 1,
        ssin: 0,
    },
    roof: noone,
    wall: {
        left: noone,
        right: noone,
        pressing: false,
    },
    grav: noone,
    excludes: [],
};


decel = 0.5;

// These values affect slipping and climbing up slopes.
frict = 1.0;
slip = 2.0;
slip_factor = 0.5; // Portion of max speed that is affected by slopes.
air_decel = 0.125;


term_velocity = 10;
wall_friction_factor = 0.25; 
jump_height = {
    min: 18,
    max: 36,
    hang: 32,
}
g = new Gravity(global.g.mag, global.g.dir);

spd = {
    x: 0,
    y: 0,
}




lateral = {
    cooldown: 0,
    wallkick_cooldown: 5,
    floor: {
        max: 8,
        accel: 1.0 + frict,
        decel: 0.5,
    },
    air: {
        max: 8,
        accel: 0.5,
        decel: 1/16,
    },
}

jump = {
    hang_speed: sqrt(2.0*g.mag*jump_height.hang),
    start_speed: sqrt(2.0*g.mag*jump_height.max),
    drop_factor: jump_height.max/jump_height.min,
    buffering: 0,
    buffering_count: 10,
    coyote: 0,
    coyote_count: 5,
    wall_factor: 1,
}


width = 12;
w_2 = width/2;
height = 26;
h_2 = height/2;

step_height = {
    floor: 10,
    air: 4,   
}

state = new_state(B_IDLE)

face = F_RIGHT;

decelerating = false;

squash_floor = body_squash_floor 
squash_block = body_squash_block