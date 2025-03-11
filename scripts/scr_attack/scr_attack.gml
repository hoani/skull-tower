function attack_update() {
    state_update(attack.state);
    
    switch attack.state.current {
        case ATTACK_NONE:
            break;
        case ATTACK_START:
            if attack.state.step >= attack.start.count {
                state_set(attack.state, ATTACK_SLASH);
                create_sfx(snd_hero_slash, x, y)
            }
            break;
        case ATTACK_SLASH:
            if attack.state.step >= attack.slash.count {
                if attack.buffering == 0 {
                    state_set(attack.state, ATTACK_NONE);
                } else {
                    state_set(attack.state, ATTACK_STAB);
                    spd.x = clamp(spd.x + face*attack.stab.xspd*2, -lateral.air.max, lateral.air.max);
                    spd.y += attack.stab.yspd;
                    create_sfx(snd_hero_slash, x, y)
                }
            }
            break;
        case ATTACK_STAB:
            if attack.state.step >= attack.stab.count {
                if attack.buffering == 0 {
                    state_set(attack.state, ATTACK_NONE);
                } else {
                    state_set(attack.state, ATTACK_SWING);
                    spd.y += attack.swing.yspd;
                    create_sfx(snd_hero_slash, x, y)
                }
            }
            break;
        case ATTACK_SWING:
            if attack.state.step >= attack.swing.count {
                state_set(attack.state, ATTACK_RECOVER);
            }
            break;
        case ATTACK_RECOVER:
            if attack.state.step >= attack.recover.count {
                state_set(attack.state, ATTACK_NONE);
            }
            break;
    }
}

function command_attack() {
    switch attack.state.current {
        case ATTACK_NONE:
            state_set(attack.state, ATTACK_START);
            return true;
        case ATTACK_START:
        case ATTACK_SLASH:
        case ATTACK_STAB:
        case ATTACK_SWING:
        case ATTACK_RECOVER:
            return false;
    }
}

function update_attack_slash() {
    attack.inst.image_index = disable ? ATTACK_NONE: attack.state.current;
    attack.inst.x = x;
    attack.inst.y = y;
    attack.inst.image_xscale = face;
    attack.inst.image_yscale = image_yscale;
    attack.inst.image_angle = g.dir - 270;
}



