scoreboard players add @s axotris.ax.debug 1
scoreboard players add @s axotris.ax.debug.x 1
execute as @s at @s run tp @s ~16 ~ ~
execute if score @s axotris.ax.debug.x matches 9.. run tp @s ~-128 ~ ~16
execute if score @s axotris.ax.debug.x matches 9.. run scoreboard players set @s axotris.ax.debug.x 0
scoreboard players set @s axotris.ax.debug.run 0
execute store success score @s axotris.ax.debug.run in axotris.ax:overworld run forceload query ~ ~
execute if score @s axotris.ax.debug.run matches 1 run particle minecraft:happy_villager ~ ~-5 ~ 1 0 1 0 100
execute if score @s axotris.ax.debug.run matches 0 run particle minecraft:flame ~ ~-5 ~ 1 0 1 0 100

execute if score @s axotris.ax.debug matches 81.. run kill @s
execute if score @s axotris.ax.debug matches ..80 as @s at @s run function axotris.ax:debug_recursive