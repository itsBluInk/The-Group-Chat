extends Node

var network = NetworkedMultiplayerENet.new()
var ip = "127.0.0.1"
var port = 6969

func _ready():
	ConnectToServer()

func ConnectToServer():
	network.create_client(ip, port)
	get_tree().set_network_peer(network)
	
	network.connect("connection_failed", self, "_OnConnectionFailed")
	network.connect("connection_succeeded", self, "OnConnectionSucceeded")

func _OnConnectionFailed():
	print("failed to connect")
	
func _OnConnectionSucceded():
	print("connected")
