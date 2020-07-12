extends Area2D

var x = 0;

func _on_AnimatedSprite_animation_finished():
	x += 1
	for child in self.get_overlapping_bodies():
		if (child.is_in_group("player")):
			child.damage(10);
	if (x == 2):
		queue_free();
