extends Control

@onready var animation = $AnimationPlayer

func _ready():
	animation.play("RESET")

func pause():
	get_tree().paused = true
	animation.play("open")
	
func resume():
	get_tree().paused = false
	animation.play_backwards("open")

func menu_activate():
	if Input.is_action_just_pressed("Escape") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Escape") and get_tree().paused:
		resume()

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	resume()
	get_tree().reload_current_scene()

func _on_main_menu_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	get_tree().quit()

func _process(_delta):
	menu_activate()
