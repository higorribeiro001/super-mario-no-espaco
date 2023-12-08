extends CharacterBody2D

var gravity = 0
@onready var animation = $anime_alien as AnimatedSprite2D;
var timer: Timer
var elapsed_time = 0	

func _ready():
	pass
	
func _process(delta):
	if velocity.x > 0:
		animation.play("moving")
	else:
		animation.play("laser") 
		if not $alien.playing:
			$alien.play()
		elapsed_time += 0.025
	
	if elapsed_time >= 4:
		get_tree().change_scene_to_file("res://scenes/the_end.tscn")
		
	move_and_slide()
	
func _on_player_detector_body_entered(body):
	velocity.x = 60
	
	if body.name == 'mario' or body.name == 'luigi':
		velocity.x = 0
		if body.has_method("set_process_input"):
			body.set_process_input(false)
	else:
		velocity.x = 60
			
	elapsed_time = 0
	
