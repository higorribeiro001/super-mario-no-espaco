extends Node

signal player_connected(peer_id, player_info)
signal player_disconnected(peer_id)
signal server_disconnected

const IP_ADDRESS = "127.0.0.1"
const PORT = 6007
const MAX_PLAYERS = 2

var player_info = {"name": "Name"}
var players_loaded = 0

var ip = IP_ADDRESS
var id = 0
var name_player = ""
var par = null #são clientes ou o proprio servidor
var players = {}

func _ready():
	multiplayer.peer_connected.connect(_on_player_connected)
	multiplayer.peer_disconnected.connect(_on_player_disconnected)
	multiplayer.connected_to_server.connect(_on_connected_ok)
	multiplayer.connection_failed.connect(_on_connected_fail)
	multiplayer.server_disconnected.connect(_on_server_disconnected)
	pass # Replace with function body.
	
func join_game(address = ""):
	if address.is_empty():
		address = IP_ADDRESS
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_client(address, PORT)
	if error:
		return error
	multiplayer.multiplayer_peer = peer
	
func create_game():
	var peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(PORT, MAX_PLAYERS)
	if error:
		return error
	multiplayer.multiplayer_peer = peer

	players[1] = player_info
	player_connected.emit(1, player_info)
	
func remove_multiplayer_peer():
	multiplayer.multiplayer_peer = null
	
@rpc("call_local", "reliable")
func load_game(game_scene_path):
	get_tree().change_scene_to_file(game_scene_path)
	
@rpc("any_peer", "call_local", "reliable")
func player_loaded():
	if multiplayer.is_server():
		players_loaded += 1
		if players_loaded == players.size():
			$/root/Game.start_game()
			players_loaded = 0
			
func _on_player_connected(id):
	_register_player.rpc_id(id, player_info)
	
@rpc("any_peer", "reliable")
func _register_player(new_player_info):
	var new_player_id = multiplayer.get_remote_sender_id()
	players[new_player_id] = new_player_info
	player_connected.emit(new_player_id, new_player_info)

func _on_player_disconnected(id):
	players.erase(id)
	player_disconnected.emit(id)
	
func _on_connected_ok():
	var peer_id = multiplayer.get_unique_id()
	players[peer_id] = player_info
	player_connected.emit(peer_id, player_info)
	
func _on_connected_fail():
	multiplayer.multiplayer_peer = null
	
func _on_server_disconnected():
	multiplayer.multiplayer_peer = null
	players.clear()
	server_disconnected.emit()

func create_server():
	par = ENetMultiplayerPeer.new()
	par.create_server(PORT, MAX_PLAYERS)
	multiplayer.set_multiplayer_peer(par) # pedindo para godot usar o par
	par.peer_disconnected.connect(self.par_disconnected) # é dever do servidor comunicar a desconexão de um cliente
	pass
	
func create_client():
	par = ENetMultiplayerPeer.new()
	par.create_client(id, PORT)
	multiplayer.set_multiplayer_peer(par) # pedindo para godot usar o par
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
