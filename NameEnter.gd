extends VBoxContainer

func _ready():
	$Join.disabled = true

func _on_Name_text_entered(new_text):
	$Join.disabled = false


func _on_Join_pressed():
	get_tree().change_scene("res://Scenes/Instances/Chat.tscn")
