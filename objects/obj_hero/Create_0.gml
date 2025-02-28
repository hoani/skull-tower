
event_inherited();

#macro H_DIE "die"

#macro IMG_IDLE_INDEX (0)
#macro IMG_JUMP_INDEX (1)
#macro IMG_RUN_INDEX (2)
#macro IMG_RUN_NUM (4)
#macro IMG_RUN_RATE (8) 
#macro IMG_WALL_INDEX (IMG_RUN_INDEX + IMG_RUN_NUM)
#macro IMG_HANG_INDEX (IMG_WALL_INDEX + 1)

#macro IMG_DIE_INDEX (0)
#macro IMG_DIE_NUM (8)
#macro IMG_DIE_RATE (4)
#macro HERO_DIE_FRAMES (IMG_DIE_NUM * IMG_DIE_RATE - 1)
