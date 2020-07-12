extends Node2D

func _ready():
	get_node("Control/anim").play("intro")
	yield(get_tree().create_timer(24),"timeout")
	get_tree().change_scene("res://main.tscn");

func _process(_delta):
	if (Input.is_action_just_pressed("ui_select")):
		get_tree().change_scene("res://main.tscn");