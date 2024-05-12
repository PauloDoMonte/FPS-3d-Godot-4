extends VBoxContainer

const World = preload("res://levels/teste/teste.tscn")

func _on_new_game_button_pressed():
	get_tree().change_scene_to_packed(World)
	

func _on_quit_game_button_pressed():
	get_tree().quit()
