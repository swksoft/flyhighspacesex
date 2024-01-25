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

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		var tween = get_tree().create_tween()
		tween.tween_property(body, "modulate", Color.RED, 0.05).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property(body, "modulate", Color.YELLOW, 0.05).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property(body, "modulate", Color.WHITE, 0.05).set_trans(Tween.TRANS_BOUNCE)
	
	#tween.tween_property(body, "scale", Vector2(), 1)
	#tween.tween_callback(body.queue_free)
	#body.modulate = "8b009f"
	#body.modulate = "ffffff"
	queue_free()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Object"):
		var tween = get_tree().create_tween()
		tween.tween_property(area, "modulate", Color(1.0, 0.0, 0.0, 1.0), 0.05).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property(area, "modulate", Color.YELLOW, 0.05).set_trans(Tween.TRANS_BOUNCE)
		tween.tween_property(area, "modulate", Color.WHITE, 0.05).set_trans(Tween.TRANS_BOUNCE)
	queue_free()

func _on_free_timeout() -> void:
	queue_free()
