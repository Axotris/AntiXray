
scoreboard players operation @s axotris.ax.x.last = @s axotris.ax.x
scoreboard players operation @s axotris.ax.z.last = @s axotris.ax.z
execute store result score @s axotris.ax.x run data get entity @s Pos[0] 1
execute store result score @s axotris.ax.z run data get entity @s Pos[2] 1
scoreboard players remove @s axotris.ax.x 8
scoreboard players remove @s axotris.ax.z 8
scoreboard players operation @s axotris.ax.x /= 16 axotris.ax.constants
scoreboard players operation @s axotris.ax.z /= 16 axotris.ax.constants
scoreboard players operation @s axotris.ax.x.last -= @s axotris.ax.x
scoreboard players operation @s axotris.ax.z.last -= @s axotris.ax.z

execute if score @s axotris.ax.x.last matches 0 if score @s axotris.ax.z.last matches 0 run return fail


forceload add ~-8 ~-8 ~8 ~8

summon marker ~-8 ~ ~-8 {Tags:["axotris.ax.chunkloading","axotris.ax.noalign"]}
summon marker ~8 ~ ~-8 {Tags:["axotris.ax.chunkloading","axotris.ax.noalign"]}
summon marker ~-8 ~ ~8 {Tags:["axotris.ax.chunkloading","axotris.ax.noalign"]}
summon marker ~8 ~ ~8 {Tags:["axotris.ax.chunkloading","axotris.ax.noalign"]}

execute as @e[type=marker,tag=axotris.ax.noalign] at @s store result score @s axotris.ax.x run data get entity @s Pos[0] 1
execute as @e[type=marker,tag=axotris.ax.noalign] at @s store result score @s axotris.ax.z run data get entity @s Pos[2] 1
execute as @e[type=marker,tag=axotris.ax.noalign] at @s run scoreboard players operation @s axotris.ax.x /= 16 axotris.ax.constants
execute as @e[type=marker,tag=axotris.ax.noalign] at @s run scoreboard players operation @s axotris.ax.z /= 16 axotris.ax.constants
execute as @e[type=marker,tag=axotris.ax.noalign] at @s run scoreboard players operation @s axotris.ax.x *= 16 axotris.ax.constants
execute as @e[type=marker,tag=axotris.ax.noalign] at @s run scoreboard players operation @s axotris.ax.z *= 16 axotris.ax.constants
scoreboard players add @e[type=marker,tag=axotris.ax.noalign] axotris.ax.x 8
scoreboard players add @e[type=marker,tag=axotris.ax.noalign] axotris.ax.z 8

execute as @e[type=marker,tag=axotris.ax.noalign] at @s run data modify entity @s data.axotris_ax_pos set value [0.0d,130.0d,0.0d]
execute as @e[type=marker,tag=axotris.ax.noalign] at @s store result entity @s data.axotris_ax_pos[0] double 1 run scoreboard players get @s axotris.ax.x
execute as @e[type=marker,tag=axotris.ax.noalign] at @s store result entity @s data.axotris_ax_pos[2] double 1 run scoreboard players get @s axotris.ax.z
execute as @e[type=marker,tag=axotris.ax.noalign] at @s run data modify entity @s Pos set from entity @s data.axotris_ax_pos

execute as @e[type=marker,tag=axotris.ax.noalign] at @s if entity @e[type=marker,tag=axotris.ax.chunkloading,tag=!axotris.ax.noalign,distance=..0.1] run kill @s

tag @e[type=marker,tag=axotris.ax.noalign] remove axotris.ax.noalign
execute as @e[type=marker,tag=axotris.ax.chunkloading] at @s in minecraft:overworld positioned ~-20 -100 ~-20 unless entity @p[dx=40,dy=1000,dz=40] run function axotris.ax:unload