extends Control

onready var chatlog = get_node("VBoxContainer/chatlog")
onready var playername = get_node("VBoxContainer/HBoxContainer/playername")
onready var message = get_node("VBoxContainer/HBoxContainer/message")
onready var colormenu = get_node("VBoxContainer/HBoxContainer/colormenu")

var colors = [
	{'name': 'white', 'color': '#ffffff'},
	{'name': 'red', 'color': '#f54e42'},
	{'name': 'orange', 'color': '#f5a742'},
	{'name': 'yellow', 'color': '#f5e042'},
	{'name': 'green', 'color': '#42f542'},
	{'name': 'cyan', 'color': '#42f5f5'},
	{'name': 'blue', 'color': '#4287f5'},
	{'name': 'violet', 'color': '#a142f5'},
	{'name': 'pink', 'color': '#f542e6'}
]

var color_index = 0

var nameFile:File = File.new()
var nameFilePath:String = 'res://UserInfo/username.json'
var username

func _ready():
	message.connect("text_entered", self, "text_entered")
	message.grab_focus()
	change_color(1)
	chatlog.get_child(0).modulate.a = 0
	LoadUsername()

func LoadUsername()->void:
	nameFile.open(nameFilePath,File.READ)
	username = (parse_json(nameFile.get_as_text()))
	nameFile.close()
	playername.text = '[' + username + ']: '

func change_color(value):
	color_index = value
	playername.set('custom_colors/font_color', Color(colors[color_index]['color']))

func add_message(username, text, color = 1):
	chatlog.bbcode_text += '\n'
	chatlog.bbcode_text += '[color=' + colors[color]['color'] + ']'
	chatlog.bbcode_text += '[' + username + ']: '
	chatlog.bbcode_text += '[/color]'
	chatlog.bbcode_text += text

func colorconfirm(text, color = 1):
	chatlog.bbcode_text += '\n'
	chatlog.bbcode_text += 'Your ID color has been changed to '
	chatlog.bbcode_text += '[color=' + colors[color]['color'] + ']'
	chatlog.bbcode_text += text
	chatlog.bbcode_text += '[/color]!'


func text_entered(text):
	if text == '/c r':
		change_color(1)
		colorconfirm('red', 1)
		message.text = ''
	elif text == '/c o':
		change_color(2)
		colorconfirm('orange', 2)
		message.text = ''
	else:
		if text != '':
			print(text)
			add_message(username, text, color_index)
			message.text = ''

