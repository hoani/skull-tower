state_update(state)


switch room {
    case rm_sloth_boss:
        sloth_controller_update(state)
        break	
    case rm_gluttony_boss:
        gluttony_controller_update(state)
        break
    //case rm_envy:
        //envy_controller_update(state)
        //break
    //case rm_lust:
        //lust_controller_update(state)
        //break
    //case rm_greed:
       //greed_controller_update(state)
       //break
    case rm_wrath_boss:
        wrath_controller_update(state)
        break 
    case rm_pride_boss:
        pride_controller_update(state)
        break
}
