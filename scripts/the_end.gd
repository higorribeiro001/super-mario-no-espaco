extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$song_game_over.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/mars.tscn")
