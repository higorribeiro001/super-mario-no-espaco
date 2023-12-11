extends Control
onready var networking = $networking.gd

func _ready():	Networking.player_loaded.rpc_id(1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
