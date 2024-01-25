extends Area2D
class_name ItemContainer

# NODES
@onready var sprite: Sprite2D = $Sprite2D
@onready var breaksfx: AudioStreamPlayer2D = $BreakSFX
@onready var collision: CollisionShape2D = $CollisionShape2D

# VARIABLES
@export var health: int = 2500
@export var damage: int = 50

# SPRITES
var half_broken = preload("res://sprites/caja2.png")
var full_broken = preload("res://sprites/caja3.png")

var rotation_velocity = randf_range(-5.0, 5.0)

var explosion_scene: PackedScene = preload("res://scripts/explosion.tscn")

func _explosion(): # FUNCIONA PERO ESTE ENEMIGO NO USA EXPLOSION
	var explosion = explosion_scene.instantiate()
	explosion.position = global_position
	get_tree().get_root().add_child(explosion)

func _damage_player(body):
	body._damage_player(damage)

func _ready() -> void:
	sprite.rotation_degrees = randf_range(0, 360)
	#print(health)
	pass
	
func _process(_delta: float) -> void:
	sprite.rotation_degrees += rotation_velocity

func _death():
	_explosion()
	collision.set_deferred("disabled",true)
	breaksfx.play()
	modulate = "ffffff00"
	visible = false
	await get_tree().create_timer(1.0).timeout
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	_damage_player(body)
	_death()

func _on_area_entered(area: Area2D) -> void:
	health -= area.damage
	print(health)
	if health < 1900 and health > 1000:
		sprite.texture = half_broken
	elif health < 1000 and health > 0:
		sprite.texture = full_broken
	elif health <= 0:
		#modulate = "ffffff00"
		_death()
