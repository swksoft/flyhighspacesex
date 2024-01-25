extends Node

var camera_shake_intensity: float = 0.0
var camera_shake_duration: float = 0.0

var on_game: bool = false

func shake(intensity, duration):
	if intensity > camera_shake_intensity and intensity > camera_shake_duration:
		camera_shake_intensity = intensity
		camera_shake_duration = duration

func _process(delta: float) -> void:
	if on_game:
		var camera = get_tree().current_scene.get_node("CameraPlayer") # ????????????????? COMO HAGO PARA QUE NO CRASHEE
		
		if camera_shake_duration <= 0:
			camera.offset = Vector2.ZERO
			camera_shake_intensity = 0.0
			camera_shake_duration = 0.0
			return

		camera_shake_duration = camera_shake_duration - delta
		
		var offset = Vector2.ZERO
		
		offset = Vector2(sin(Time.get_ticks_msec()*0.03), sin(Time.get_ticks_msec()*0.07)) * camera_shake_intensity * 0.5
		
		camera.offset = offset
	else:
		return
	pass
	
