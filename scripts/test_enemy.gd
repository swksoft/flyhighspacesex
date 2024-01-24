extends CharacterBody2D

@onready var player = get_parent().get_node("Player")
var player_position
var direction := Vector2.LEFT
var speed: int = 0

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	player_position = player.position
	look_at(player_position)
	
	
