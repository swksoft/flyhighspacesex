extends CanvasLayer

@onready var animation : AnimationPlayer = $AnimationPlayer

func change_scene(target: String) -> void:
	animation.play("fade_in")
	await animation.animation_finished
	TransitionLayer.change_scene_to_file(target)
	animation.play_backwards("fade_in")
