#macro BOSS_INTRO (0)
#macro BOSS_FIGHT (1)
#macro BOSS_DEFEAT (2)

#macro BI_SLOTH (0)
#macro BI_GLUTTONY (1)
#macro BI_ENVY (2)
#macro BI_LUST (3)
#macro BI_GREED (4)
#macro BI_WRATH (5)
#macro BI_PRIDE (6)



function boss_registry_init(){
    global.br = [
        BOSS_INTRO,
        BOSS_INTRO,
        BOSS_INTRO,
        BOSS_INTRO,
        BOSS_INTRO,
        BOSS_INTRO,
        BOSS_INTRO,
    ]
}

function boss_registry_get(index) {
    if index <= BI_PRIDE {
        return global.br[index];
    }
    return BOSS_INTRO;
}

function boss_registry_set(index, val) {
    if index <= BI_PRIDE {
        global.br[index] = val;
    }
}