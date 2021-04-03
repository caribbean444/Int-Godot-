extends Control

var player = preload("res://Player/Player.tscn")

onready var multiplayer_config_ui = $"Multiplayer configure"
onready var server_ip_adress = $"Multiplayer configure/Server IP"
onready var device_ip_adress = $"CanvasLayer/Device IP"

func _ready() -> void:
	get_tree().connect("network_peer_connected", self, "_player_connected")
	get_tree().connect("network_peer_disconnected", self, "_player_disconnected")
	get_tree().connect("connected_to_server", self, "_connected_to_server")
	
	print(str(Network.ip_adress), " IP")
	device_ip_adress.text = Network.ip_adress

	
func _player_connected(id) -> void:
	print("Player" + str(id) + " has connected")
	
	instance_player(id)
	
func _player_disconnected(id) -> void:
	print("Player" + str(id) + " has disconnected")
	
	if Players.has_node(str(id)):
		Players.get_node(str(id)).queue_free()
	
func _on_Create_server_pressed():
		multiplayer_config_ui.hide()
		Network.create_server()
		
		instance_player(get_tree().get_network_unique_id())
		
func _connected_to_server() -> void:
	yield(get_tree().create_timer(0.1), "timeout")
	instance_player(get_tree().get_network_unique_id())
		

func _on_Join_server_pressed():
	if server_ip_adress.text != "":
		multiplayer_config_ui.hide()
		Network.ip_adress = server_ip_adress.text #!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
		Network.join_server()
		

func instance_player(id) -> void:
	var player_instanse = Global.instance_node_at_location(player, Players, Vector2(rand_range(0, 960), rand_range(0, 1080)))
	player_instanse.name = str(id)
	player_instanse.set_network_master(id)
