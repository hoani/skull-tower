

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


// These values affect slipping and climbing up slopes.
frict = 1.0;
slip = 2.0;
slip_factor = 0.5; // Portion of max speed that is affected by slopes.


term_velocity = 3;
wall_term_velocity = 1.5;
wall_friction_factor = 0.5; 

g = new Gravity(global.g.mag, global.g.dir);

spd = {
    x: 0,
    y: 0,
}


lateral = {
    cooldown: 0,
    wallkick_cooldown: 5,
    floor: {
        max: 2,
        accel: 0.25 + frict,
        frict: frict,
    },
    air: {
        max: 2,
        accel: 0.25,
        decel: 1/32,
    },
}

jump_height = {
    min: 8,
    max: 18,    
    double: 22,
    hang: 16,
}

jump = {
    hang_speed: sqrt(2.0*g.mag*jump_height.hang),
    start_speed: sqrt(2.0*g.mag*jump_height.max),
    double_speed: sqrt(2.0*g.mag*jump_height.double),
    drop_factor: jump_height.max/jump_height.min,
    buffering: 0,
    buffering_count: 10,
    coyote: 0,
    coyote_count: 5,
    wall_factor: 1,
    double: true,
}

dash = {
    min: 24,
    max: 48,
    target: 0,
    cooldown: 0,
    cooldown_count: 8,
    trigger: false,
    target: 0,
    distance: 0,
    x: 0,
    y: 0,
    face: F_LEFT, // helps when dashing from wall.
}

#macro ATTACK_NONE (0)
#macro ATTACK_START (1)
#macro ATTACK_SLASH (2)
#macro ATTACK_STAB (3)
#macro ATTACK_SWING (4)
#macro ATTACK_RECOVER (5)



attack = {
    inst: instance_create_hero(x, y, obj_hero_slash, { depth: depth -1 }),
    state: new_state(ATTACK_NONE),
    start: {count: 4},
    slash: { xspd: 0, yspd: 0, count: 12 },
    stab: { xspd: 1, yspd: -1, count: 6 },
    swing: { xspd: 0, yspd: -1.5, count: 12 },
    recover: { count: (IMG_ATTACK_RECOVER_NUM * IMG_ATTACK_RECOVER_RATE) },
    buffering: 0,
    buffering_count: 10,
}


width = 8;
w_2 = width/2;
height = 8;
h_2 = height/2;

step_height = {
    floor: 4,
    air: 4,   
}

state = new_state(B_IDLE)

face = F_RIGHT;

decelerating = false;


disable = false;


lateral_init()
