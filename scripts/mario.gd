extends CharacterBody2D

var gravity = 4
@onready var animation = $anima_mario as AnimatedSprite2D;
var jumping = false
var moving = true
var coins = 0

func _ready():
	pass
	
func _process(delta):
	$coins.text = str(coins)
	if moving == true:
		if is_on_floor() == false:
			velocity.y += gravity
		
		if is_on_floor() == true:
			if Input.is_action_just_pressed("ui_up"):
				velocity.y = -200
				jumping = true
				
				if not $jump_mario.playing:
					$jump_mario.play()
					
				if Input.is_action_pressed("ui_left"):
					velocity.x = -140
					animation.scale.x = -1
				elif Input.is_action_pressed("ui_right"):
					velocity.x = 140
					animation.scale.x = 1
			
			if Input.is_action_pressed("ui_left"):
				velocity.x = -100
				velocity.y = -140
				animation.scale.x = -1
				jumping = true
				
				if not $jump_mario.playing:
					$jump_mario.play()
			elif Input.is_action_pressed("ui_right"):
				velocity.x = 140
				velocity.y = -150
				animation.scale.x = 1
				jumping = true
				
				if not $jump_mario.playing:
					$jump_mario.play()
			else:
				velocity.x = 0
				
		if (is_on_floor() == false) and (jumping == true):
			animation.play("jump")
		else:
			animation.stop()
			
		move_and_slide()
