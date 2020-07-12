extends Node2D

export(float) var SPEED = 15;
export(float) var DAMAGE = 15;

var EXPLOSION_VFX : PackedScene = preload("res://vfx/bullet/explosionvfx.tscn");

var INITIAL_VECTOR : Vector2 = Vector2(); 

func _ready():
	set_as_toplevel(true);
	rotation = INITIAL_VECTOR.angle() + deg2rad(-90) ;

func _process(delta):
	rotation = INITIAL_VECTOR.angle() + deg2rad(-90) ;
	translate((INITIAL_VECTOR * SPEED));
	
	

func _on_Bullet_body_entered(body : Node):
	
	if (!body.is_in_group("player")):
		# HANDLE EXPLOSION 
		var vfx = EXPLOSION_VFX.instance();
		get_tree().get_root().add_child(vfx);
		vfx.position = self.global_position;
		vfx.rotation = self.rotation+ deg2rad(-90);
		vfx.set_as_toplevel(true);
		if (body.is_in_group("enemy")):
			body.damage(DAMAGE);
		queue_free();


