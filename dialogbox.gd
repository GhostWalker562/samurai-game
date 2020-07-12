#DialogueBox.gd
extends RichTextLabel
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var dialog = ["Hello! Welcome to the game!", "Use WASD to move."]
var page = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	if Input.is_key_pressed(KEY_K):
		Polygon2D.visible
		set_bbcode(dialog[page]) # Replace with function body.
		set_visible_characters(0)
		set_process_input(true)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
# pass
func _input(event):
	if Input.is_mouse_button_pressed(1):
		if get_visible_characters() > get_total_character_count():
			if page < dialog.size()-1:
				page += 1
				set_bbcode(dialog[page])
				set_visible_characters(0)
		else:
			set_visible_characters(get_total_character_count())

func _on_Timer_timeout():
	set_visible_characters(get_visible_characters()+1) # Replace with function body.
