extends Control

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
	
func _player_disconnected(id) -> void:
	print("Player" + str(id) + " has disconnected")
	


func _on_Create_server_pressed():
	if server_ip_adress.text != "":
		multiplayer_config_ui.hide()
		Network.create_server()


func _on_Join_server_pressed():
	multiplayer_config_ui.hide()
	Network.join_server()
