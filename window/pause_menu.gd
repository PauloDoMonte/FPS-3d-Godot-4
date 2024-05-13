extends VBoxContainer

const World = preload("res://levels/teste/teste.tscn")

@onready var pause_menu = $/root/teste/ui/pausemenu/pause_menu
@onready var teste = $/root/teste
#"/root/teste/ui/pausemenu/pause_menu/MarginContainer/VBoxContainer").


func _on_resume_pressed():
	#paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pause_menu.visible = false
	teste.paused = false
	Engine.time_scale = 1
	

func _on_new_pressed():
	Engine.time_scale = 1
	get_tree().change_scene_to_packed(World)

	
func _on_quit_pressed():
	get_tree().quit()
