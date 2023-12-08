extends CharacterBody2D

var gravity = 4
@onready var animation = $anima_luigi as AnimatedSprite2D;
var jumping = false

func _ready():
	pass
	
func _process(delta):
	if not is_on_floor():
		velocity.y += gravity
	
	if is_on_floor() == true:
		if Input.is_action_just_pressed("ui_up"):
			velocity.y = -300
			jumping = true
			
			if not $jump_mario.playing:
				$jump_mario.play()
		
			if Input.is_action_pressed("ui_left"):
				velocity.x = -140
			elif Input.is_action_pressed("ui_right"):
				velocity.x = 90
		
	else:
		velocity.x = 0
			
	if (is_on_floor() == true) and (jumping == true):
		animation.play("jump")
		
	move_and_slide()
