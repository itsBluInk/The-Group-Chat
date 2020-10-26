extends Control

onready var chatlog = get_node("VBoxContainer/chatlog")
onready var playername = get_node("VBoxContainer/HBoxContainer/playername")
onready var message = get_node("VBoxContainer/HBoxContainer/message")
onready var colormenu = get_node("VBoxContainer/HBoxContainer/colormenu")

# color variables
var colors = [
	{'name': 'white', 'color': '#ffffff'},
	{'name': 'red', 'color': '#f54e42'},
	{'name': 'orange', 'color': '#f5a742'},
	{'name': 'yellow', 'color': '#f2f542'},
	{'name': 'green', 'color': '#42f542'},
	{'name': 'cyan', 'color': '#42f5f5'},
	{'name': 'blue', 'color': '#4287f5'},
	{'name': 'violet', 'color': '#a142f5'},
	{'name': 'pink', 'color': '#f542e6'}
]

var color_index 

var colorFile:File = File.new()
var colorFilePath:String = 'res://UserInfo/color.json'
var chosencolor

# username variables
var nameFile:File = File.new()
var nameFilePath:String = 'res://UserInfo/username.json'
var username

#disorganized functions
func _ready():
	message.connect("text_entered", self, "text_entered")
	message.grab_focus()
	chatlog.get_child(0).modulate.a = 0
	LoadUsername()
	LoadColor()

func LoadColor()->void:
	colorFile.open(colorFilePath,File.READ)
	chosencolor = parse_json(colorFile.get_as_text())
	colorFile.close()
	change_color(chosencolor)

func SaveColor()->void:
	colorFile.open(colorFilePath,File.WRITE)
	colorFile.store_line(to_json(chosencolor))
	colorFile.close()
	print('color saved!')

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
	chatlog.bbcode_text += ' ● ⬤⬤Your ID color has been changed to '
	chatlog.bbcode_text += '[color=' + colors[color]['color'] + ']'
	chatlog.bbcode_text += text
	chatlog.bbcode_text += '[/color]!'

func commandrespond(text):
	chatlog.bbcode_text += '\n'
	chatlog.bbcode_text += text

func text_entered(text):
	if text == '/c r':
		colorconfirm('red', 1)
		message.text = ''
		chosencolor = 1
		change_color(chosencolor)
		SaveColor()
	elif text == '/c o':
		colorconfirm('orange', 2)
		message.text = ''
		chosencolor = 2
		change_color(chosencolor)
		SaveColor()
	elif text == '/c y':
		colorconfirm('yellow', 3)
		message.text = ''
		chosencolor = 3
		change_color(chosencolor)
		SaveColor()
	elif text == '/c g':
		colorconfirm('green', 4)
		message.text = ''
		chosencolor = 4
		change_color(chosencolor)
		SaveColor()
	elif text == '/c c':
		colorconfirm('cyan', 5)
		message.text = ''
		chosencolor = 5
		change_color(chosencolor)
		SaveColor()
	elif text == '/c b':
		colorconfirm('blue', 6)
		message.text = ''
		chosencolor = 6
		change_color(chosencolor)
		SaveColor()
	elif text == '/c v':
		colorconfirm('violet', 7)
		message.text = ''
		chosencolor = 7
		change_color(chosencolor)
		SaveColor()
	elif text == '/c p':
		colorconfirm('pink', 8)
		message.text = ''
		chosencolor = 8
		change_color(chosencolor)
		SaveColor()
	elif text == '/c':
		commandrespond('available colors: \n     [color=#f54e42]red[/color] /c r \n     [color=#f5a742]orange[/color] /c o \n     [color=#f2f542]yellow[/color] /c y \n     [color=#42f542]green[/color] /c g \n     [color=#42f5f5]cyan[/color] /c c \n     [color=#4287f5]blue[/color] /c b \n     [color=#a142f5]violet[/color] /c v \n     [color=#f542e6]pink[/color] /c p')
		message.text = ''
	elif text == '/help':
		commandrespond('commands: \n   /c [i]tells you how to change the color of your username[/i] \n')
		message.text = ''
	else:
		if text != '':
			print(text)
			add_message(username, text, color_index)
			message.text = ''

