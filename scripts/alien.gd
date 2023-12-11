extends CharacterBody2D

var gravity = 0
@onready var animation = $anime_alien as AnimatedSprite2D;
var timer: Timer
var elapsed_time = 0	
var player: Array = []

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
		if player.size() > 0: 
			var player_instance = player[0]
			print(player)
			player_instance.queue_free()
			player.pop_front()
			velocity.x = 60
		
	move_and_slide()
	
func _on_player_detector_body_entered(body):
	velocity.x = 60
	
	if body.name == 'mario' or body.name == 'luigi':
		velocity.x = 0
		body.velocity.y = 0
		body.velocity.x = 0
		body.moving = false
		player.append(body)
	else:
		velocity.x = 60
			
	elapsed_time = 0
	
