extends AnimatedSprite

var x : int = 0;

onready var anim = get_node("AnimationPlayer")

func _ready():
	anim.play("Fade");

func _on_BossDeath_animation_finished():
	if (x == 2):
		queue_free();
	x +=1;
