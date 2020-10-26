extends VBoxContainer

var nameFile:File = File.new()
var nameFilePath:String = 'res://UserInfo/username.json'
var username

func _ready():
	$Join.disabled = true
	LoadUsername()

func LoadUsername()->void:
	nameFile.open(nameFilePath,File.READ)
	username = (parse_json(nameFile.get_as_text()))
	nameFile.close()
	if username != '':
		get_tree().change_scene("res://Scenes/Instances/Chat.tscn")

func checkUsername():
	if username != "":
		get_tree().change_scene("res://Scenes/Instances/Chat.tscn")
	else:
		pass

func _on_Name_text_entered(new_text):
	$Join.disabled = false
	username = new_text
	print(username)
	saveusername()

func saveusername()->void:
	nameFile.open(nameFilePath,File.WRITE)
	nameFile.store_line(to_json(username))
	nameFile.close()
	print("Username Saved!")

func _on_Join_pressed():
	get_tree().change_scene("res://Scenes/Instances/Chat.tscn")
