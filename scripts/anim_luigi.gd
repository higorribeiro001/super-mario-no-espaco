extends CharacterBody2D

var gravity = 0
@onready var animation = $anim as AnimatedSprite2D;
@onready var remote_transform := $remote as RemoteTransform2D

func _ready():
	var song_ship = load("res://resources/songs/nave.mp3")
	var ship_running = load("res://resources/songs/nave_running.wav")
	
func _process(delta):
	if not $song_ship.playing:
		$song_ship.play()
	if Input.is_action_pressed("ui_up"):
		velocity.y = -70
	elif Input.is_action_pressed("ui_down"):
		velocity.y = 70
	else:
		velocity.y = 0
		
	if Input.is_action_pressed("ui_left"):
		velocity.x = -140
	elif Input.is_action_pressed("ui_right"):
		velocity.x = 90
		animation.play("piloting")
		#if not $ship_running.playing:  
			#$ship_running.play()
	else:
		velocity.x = 0
		animation.play("idle")
	
	move_and_slide()
	
func follow_camera(camera):
	var camera_path = camera.get_path()
	remote_transform.remote_path = camera_path
