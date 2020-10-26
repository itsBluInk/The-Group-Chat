extends Control

onready var chatlog = get_node("VBoxContainer/chatlog")
onready var playername = get_node("VBoxContainer/HBoxContainer/playername")
onready var message = get_node("VBoxContainer/HBoxContainer/message")
onready var colormenu = get_node("VBoxContainer/HBoxContainer/colormenu")

var colors = [
	{'name': 'red', 'color': '#f54e42'},
	{'name': 'orange', 'color': '#f5a742'},
	{'name': 'yellow', 'color': '#f5e042'},
	{'name': 'lime', 'color': '#c5f542'},
	{'name': 'green', 'color': '#7bf542'},
	{'name': 'cyan', 'color': '#42f5f5'},
	{'name': 'blue', 'color': '#4287f5'},
	{'name': 'purple', 'color': '#a142f5'},
	{'name': 'pink', 'color': '#f542e6'}
]

var color_index = 0
var username = "Ghost" 

func _ready():
	message.connect("text_entered", self, "text_entered")
	message.grab_focus()
	playername.text = '[' + username + ']: '

func add_message(username, text, color = 0):
	chatlog.bbcode_text += '\n'
	chatlog.bbcode_text += '[color=' + colors[color]['color'] + ']'
	chatlog.bbcode_text += '[' + username + ']: '
	chatlog.bbcode_text += '[/color]'
	chatlog.bbcode_text += text

func text_entered(text):
	print(text)
	add_message(username, text, color_index)
	message.text = ''


