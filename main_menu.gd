extends Control

@onready var exit = $CanvasLayer/Options/VBoxContainer/Exit
@onready var parallax_menu = $ParallaxMenu

var cursor = preload("res://sprites/arrowani1.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	%Start.grab_focus()
	#Input.set_custom_mouse_cursor(cursor)
	SHAKE.on_game = false
	
	match OS.get_name():
		"Windows":
			pass
		"macOS":
			pass
		"Linux", "FreeBSD", "NetBSD", "OpenBSD", "BSD":
			pass
		"Android":
			exit.disabled = true
		"iOS":
			exit.disabled = true
		"Web":
			exit.disabled = true

func _process(_delta):
	Input.set_custom_mouse_cursor(cursor)
	pass

func _on_start_pressed():
	#get_tree().change_scene_to_file("res://test_room.tscn")
	TransitionLayer.change_scene("res://test_room.tscn")

func _on_options_pressed():
	pass # Replace with function body.

func _on_exit_pressed():
	get_tree().quit()
