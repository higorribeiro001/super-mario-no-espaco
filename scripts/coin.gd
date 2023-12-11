extends Area2D

@onready var coin := $anim as AnimatedSprite2D
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	coin.play("pegando")
	if body.name == "mario":
		body.coins += 1
	if body.name == "luigi":
		body.coins += 1
	queue_free()
	
func _on_anim_animation_finished():
	queue_free()
