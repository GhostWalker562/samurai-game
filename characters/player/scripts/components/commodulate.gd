extends Node2D

onready var anim = get_node("anim");

func _dash_modulate():
	anim.play("blue_flash");

func _hit_modulate():
	anim.play("red_flash")