extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not $music_mario.playing:
		$music_mario.play()
		
	if (is_instance_valid($mario)==false) and (is_instance_valid($luigi)==false):
		get_tree().change_scene_to_file("res://scenes/the_end.tscn")
