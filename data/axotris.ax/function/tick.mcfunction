# execute as @a at @s run function axotris.ax:debug
execute as @e[type=marker] at @s run particle angry_villager ~ ~ ~ 0 0 0 0 0
#---------------------------------------------------------------------------------------------------------------------------------#
advancement revoke @a[scores={axotris.ax.leave=1..}] only axotris.ax:join


# check from each player if hes crossing a chunk boarder
execute as @a at @s if dimension minecraft:overworld in axotris.ax:overworld run function axotris.ax:check

# clone deepslate and stone from the x-ray dimension to the real one to replace fake ores with real deepslate
execute as @a at @s if dimension minecraft:overworld in axotris.ax:overworld run clone ~-6 ~-6 ~-6 ~6 ~6 ~6 to minecraft:overworld ~-6 ~-6 ~-6 filtered #axotris.ax:replace

# find out position of explodion of impact explosives (fireball, wither skulls) and run function axotris.ax/explosives/fireball_witherskull from the exploding position
execute as @e[type=#axotris.ax:impact_explosive,tag=!axotris.ax.impact_explosive_with_marker] at @s run summon marker ~ ~ ~ {Tags:["axotris.ax.impact_explosive"]}
execute as @e[type=#axotris.ax:impact_explosive,tag=!axotris.ax.impact_explosive_with_marker] at @s run ride @e[type=marker,tag=axotris.ax.impact_explosive,distance=..0.1,sort=nearest,limit=1] mount @s
execute as @e[type=#axotris.ax:impact_explosive,tag=!axotris.ax.impact_explosive_with_marker] at @s run tag @s add axotris.ax.impact_explosive_with_marker
execute as @e[type=marker,tag=axotris.ax.impact_explosive] at @s unless predicate axotris.ax:riding_explosive run function axotris.ax:explosives/fireball_witherskull

# find out position of exploding creeper and run function axotris.ax:explosives/tnt_creeper from the exploding position
execute as @e[type=tnt,nbt={fuse:1s}] at @s if dimension minecraft:overworld run function axotris.ax:explosives/tnt_creeper

# find out position of exploding tnt and run function axotris.ax:explosives/tnt_creeper from the exploding position
execute as @e[type=creeper,nbt={ignited:1b}] at @s if dimension minecraft:overworld run scoreboard players add @s axotris.ax.fuse 1
execute as @e[type=creeper,scores={axotris.ax.fuse=30..}] at @s if dimension minecraft:overworld run function axotris.ax:explosives/tnt_creeper
execute as @e[type=creeper,scores={axotris.ax.fuse=1..},nbt={HurtTime:10s}] at @s if dimension minecraft:overworld run function axotris.ax:explosives/tnt_creeper

# find out position of enderdragon and run function axotris.ax:explosives/enderdragon from the position
execute as @e[type=ender_dragon] at @s if dimension minecraft:overworld run function axotris.ax:explosives/enderdragon

# find out position of creeper that took a block and run function axotris.ax:explosives/enderman from the position
execute as @e[type=enderman,nbt={carriedBlockState:{}}] at @s if dimension minecraft:overworld unless score @s axotris.ax.carriedblock matches 2.. run scoreboard players add @s axotris.ax.carriedblock 1
execute as @e[type=enderman,nbt=!{carriedBlockState:{}}] at @s if dimension minecraft:overworld run scoreboard players set @s axotris.ax.carriedblock 0
execute as @e[type=enderman,scores={axotris.ax.carriedblock=1}] at @s if dimension minecraft:overworld run function axotris.ax:explosives/enderman


# replace stone and deepslate with diorite and sandstone in the x-ray dimension, so it only clones one time
execute as @a at @s if dimension minecraft:overworld in axotris.ax:overworld run fill ~-6 ~-6 ~-6 ~6 ~6 ~6 minecraft:diorite replace #axotris.ax:replace