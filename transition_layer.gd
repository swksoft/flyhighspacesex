extends CanvasLayer

@onready var animation : AnimationPlayer = $AnimationPlayer

func _process(_delta):
	SHAKE.on_game = false

func change_scene(target: String) -> void:
	animation.play("fade_in")
	await animation.animation_finished
	#TransitionLayer.change_scene(target)
	#get_tree().change_scene_to_file(target)
	TransitionLayer.get_tree().change_scene_to_file(target)
	animation.play("fade_out")
