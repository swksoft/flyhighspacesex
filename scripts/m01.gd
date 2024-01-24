extends Node2D

signal level_clear
signal level_trigger

const  VEL_BG = 50
var col = false
var start = false

@onready var BG: Node2D = $"."

func _process(delta: float) -> void:
	if start:
		if !col:
			BG.position.x -= VEL_BG * delta
		else:
			pass
	else:
		pass

func _on_triggers_area_entered(_area: Area2D) -> void:
	var n_trigger = 0
	
	#while n_trigger >= 11:
		#print("Trigger ", n_trigger)
		#n_trigger >= 1
		
	for i in n_trigger:
		print("Trigger ", n_trigger)

func _on_pito_area_entered(_area: Area2D) -> void:
	level_trigger.emit()
	

func _on_area_stop_area_entered(area: Area2D) -> void:
	col = true
	level_clear.emit()


func _on_start_timeout() -> void:
	start = true
