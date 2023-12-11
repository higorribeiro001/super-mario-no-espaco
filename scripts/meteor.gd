extends CharacterBody2D

@onready var animation = $anim as AnimatedSprite2D;

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity.x = -40
	animation.play("moving")
	
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.name == "ship_mario" or body.name=="ship_luigi":
		get_tree().change_scene_to_file("res://scenes/the_end.tscn")
