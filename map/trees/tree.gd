extends Sprite

onready var player = get_node("../../Player");

func _process(_delta):
	#print((self.global_position - player.global_position).length())
	var opacity : float = ((self.global_position - player.global_position).length()/200)
	if (opacity>1):
		opacity = 1
	self.modulate = Color(1,1,1,opacity)

