extends Node2D

@onready var animation = $AnimationPlayer
@onready var sfx = $AudioStreamPlayer2D

func _ready():
	animation.play("explode")
	sfx.play()
	await animation.animation_finished
	queue_free()
