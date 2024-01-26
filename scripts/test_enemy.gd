extends CharacterBody2D

@onready var block = $AreaCoraza/Block

@onready var player = get_parent().get_node("Player")
var player_position
#var direction := Vector2.LEFT

# Variables
@export var health : float = 800.0
@export var damage : float = 150.0
@export var speed : int = 0
@export var points : float = 10.0
@export var direction := Vector2.LEFT

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	player_position = player.position
	look_at(player_position)
	
func _on_area_coraza_area_entered(area):
	block.emitting = true
	#display(damage-damage)

