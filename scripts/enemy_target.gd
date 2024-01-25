extends CharacterBody2D

# Nodes
@onready var collision : CollisionShape2D = $CollisionEnemy
@onready var sprite : Sprite2D = $SpriteEnemy
@onready var light : Light2D = $LightEnemy
@onready var animation : AnimationPlayer = $AnimationEnemy

@onready var damaged_sfx = $SFX/DamagedSFX
@onready var defeated_sfx = $SFX/DefeatedSFX
@onready var spawn_sfx = $SFX/SpawnSFX
@onready var sound_sfx = $SFX/SoundSFX

# Variables
@export var health : float = 500.0
@export var damage : float = 50.0
@export var speed : int = 0
@export var points : float = 10.0
#var direction : Vector2 = Vector2.ZERO

# SCENE
@export var explosion_scene: PackedScene

func _explosion(): # FUNCIONA PERO ESTE ENEMIGO NO USA EXPLOSION
	var explosion = explosion_scene.instantiate()
	explosion.position = global_position
	get_tree().get_root().add_child(explosion)

func _damage_enemy(area):
	health -= area.damage

func _damage_player(body):
	body._damage_player(damage)

func _moveto(direction, delta):
	position += direction * speed * delta

func _physics_process(delta: float) -> void:
	_moveto(Vector2.ZERO, delta)

func _death():
	defeated_sfx.play()
	animation.play("death")
	_explosion()
	await animation.animation_finished
	#_explosion()
	queue_free()

func _on_area_daño_body_entered(body):
	_damage_player(body)
	_death()

func _on_area_daño_area_entered(area):
	_damage_enemy(area)
	
	if health <= 0:
		_death()
