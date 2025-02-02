extends Node2D

# THIS NODE TRANSFERS DATA INBETWEEN THE PLAYER AND THE COMPONENTS

# Player node
onready var PLAYER : KinematicBody2D = get_node("..");
# GUI node
onready var GUI : Control = get_node("../Camera2D/GUI/Control");


func get_aim_angle():
	return PLAYER.rotation;

func get_global_pos():
	return PLAYER.global_position;

func get_gui():
	return GUI