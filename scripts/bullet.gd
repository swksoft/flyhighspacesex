extends Area2D

# NODES
@onready var free_timer: Timer = $Free

# VARIABLES
@export var speed: float = 1000.0
@export var damage: int = 100
var direction: Vector2 = Vector2.RIGHT
var spread: Array = [-0.1, 0, 0.1]

func _ready() -> void:
	free_timer.start()

func _process(delta: float) -> void:
	position += direction * speed * delta
	# position += direction * speed * delta + Vector2(0,(randf_range(-10,10))) (BALAS CHISTOSAS)

func _on_body_entered(_body: Node2D) -> void:
	queue_free()

func _on_area_entered(_area: Area2D) -> void:
	queue_free()

func _on_free_timeout() -> void:
	queue_free()
