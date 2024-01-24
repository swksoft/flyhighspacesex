extends Area2D
class_name InteractiveContainer

# NODES
@onready var sprite = $Sprite2D
@onready var collision = $CollisionShape2D

# STATISTICS
@export var health: int = 0
@export var damage: int = 0

func _damage_player(interactive_damage):
	interactive_damage._damage_player(damage)

func _damage_interactive(player_bullet):
	health -= player_bullet.damage
	if health < 1:
		_death()

func _death():
	collision.set_deferred("disabled",true)
	modulate = "ffffff00"
	await get_tree().create_timer(1.8).timeout
	queue_free()

func _ready() -> void:
	sprite.rotation_degrees = 0
	
func _process(_delta: float) -> void:
	#sprite.rotation_degrees += rotation_velocity
	pass

func _on_area_entered(area): # CONTACTO POR BALA
	_damage_interactive(area.damage)

func _on_body_entered(body): # CONTACTO CON EL JUGADOR
	_damage_player(body)
