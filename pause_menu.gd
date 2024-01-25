extends Control

@onready var animation = $AnimationPlayer
#var cursor = preload("res://sprites/arrowani1.png")

func _ready():
	SHAKE.on_game = true
	animation.play("RESET")

func pause():
	get_tree().paused = true
	animation.play("open")
	
func resume():
	animation.play_backwards("open")
	await animation.animation_finished
	get_tree().paused = false

func menu_activate():
	#Input.set_custom_mouse_cursor(cursor)
	if Input.is_action_just_pressed("Escape") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("Escape") and get_tree().paused:
		resume()

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	SHAKE.on_game = false
	resume()
	TransitionLayer.change_scene("res://test_room.tscn")
	
	#get_tree().reload_current_scene()
	#TransitionLayer.change_scene("res://test_room.tscn")
	
func _on_main_menu_pressed():
	SHAKE.on_game = false
	modulate = "ffffff00"
	TransitionLayer.change_scene("res://main_menu.tscn")
	get_tree().paused = false
	#get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_quit_pressed():
	get_tree().quit()

func _process(_delta):
	menu_activate()
