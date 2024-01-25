extends CharacterBody2D
const SPEED = 230.0

# NODES
@onready var cooldown_shoot: Timer = $Cooldown
@onready var player: CharacterBody2D = $"."
@onready var projectiles_positions: Node2D = $ProjectilesPositions
@onready var particles: GPUParticles2D = $Particles
@onready var player_sprite: Sprite2D = $Sprite2D
@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var colision: CollisionShape2D = $CollisionShape2D
@onready var trails = $Trails

# SFX
@onready var shoot_sfx: AudioStreamPlayer2D = $SFX/Shootsfx
@onready var death_sfx: AudioStreamPlayer2D = $SFX/Deathsfx
@onready var intro_sfx: AudioStreamPlayer2D = $SFX/Introsfx
@onready var damage_sfx: AudioStreamPlayer2D = $SFX/Damagesfx
@onready var ouch_sfx: AudioStreamPlayer2D = $SFX/Ouchsfx
var sfx_array = [preload("res://sfx/sex_damage.wav"), preload("res://sfx/sex_damage2.wav"), preload("res://sfx/sex_damage3.wav"), preload("res://sfx/sex_damage4.wav"), preload("res://sfx/sex_damage5.wav")]

# SCENES
var bullet_scene: PackedScene = preload("res://scripts/bullet.tscn")

# VARIABLES
var can_shoot: bool = true
@export var health : float = 500.0
var cursor = preload("res://gui/cursor.png")

#func
func _ready() -> void:
	intro_sfx.play()

func _defeat():
	pass

func _damage_player(damage):
	health -= damage
	#var tween = get_tree().create_tween()
	#tween.tween_property(player_sprite, "modulate", Color("ffffff3e"), 0.015)

	# SHAKE
	SHAKE.shake(5, 0.2)

	# SFX
	ouch_sfx.play()
	
	var sfx_pick = sfx_array[randi() % sfx_array.size()]
	damage_sfx.set_stream(sfx_pick)
	damage_sfx.volume_db = -10
	damage_sfx.play()
	
	#print(health)
	animation.play("invul")
	await animation.animation_finished
	
	if health >= 0:
		_defeat()

func _player_health(amount):
	health += amount
	print(health)

func _movement():
	var direction := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down"):
		trails.emitting= true
	else:
		trails.emitting= false
	#position += direction * SPEED * delta (NO HACE FALTA CON move_and_slide())
	velocity = direction * SPEED
	move_and_slide() # incluye delta

func _rotation():
	look_at(get_global_mouse_position())
	var player_direction: Vector2 = (get_global_mouse_position() - position).normalized()
	return player_direction

func _shoot_sfx():
	shoot_sfx.pitch_scale = randf_range(1.0, 1.1)
	shoot_sfx.play()
	
func _shoot_cooldown():
	can_shoot = false
	cooldown_shoot.start()

func _bullet_position(bullet_instance):
	var bullet_markers = projectiles_positions.get_children()
	var selected_marker = bullet_markers[randi() % bullet_markers.size()]
	#bullet.rotation_degrees = rad_to_deg(randf_range(0,90))
	bullet_instance.position = selected_marker.global_position

func _bullet_rotation(bullet_instance):
	# (NO TRAYECTORIA)
	bullet_instance.rotation_degrees = rotation_degrees #rad_to_deg(player_direction.angle()) (LO MISMO PERO MAS LARGO)

func _bullet_spawn(bullet_instance):
	#add_child(bullet) (NO FUNCIONA: The bullet being spawned is attached to the player, so whenever the player moves, its children -the bullets- move in the same direction.)
	get_tree().get_root().add_child(bullet_instance) # Lo soluciona
	
func _bullet_trajectory(bullet_instance, player_direction):
	bullet_instance.direction = player_direction
	#bullet.direction = Vector2(player_direction.x,randf_range(-0.1,0.1))
	
func _particles(boolean):
	particles.emitting = boolean
	
func _shoot(player_direction):
	var bullet_instance = bullet_scene.instantiate() as Area2D
	#bullet.position += Vector2(0,0)#player.global_position
	#bullet.position = global_position
	
	# POSICION SPAWN BALA
	_bullet_spawn(bullet_instance)
	# ROTACION SPRITE BALA (NO TRAYECTORIA)
	_bullet_rotation(bullet_instance)
	# TRAYECTORIA BALA
	_bullet_trajectory(bullet_instance, player_direction)
	# SPAWN BALA 
	_bullet_position(bullet_instance)
	# COOLDOWN
	_shoot_cooldown()
	# PARTICULAS
	_particles(true)
	# SONIDO DE DISPARO
	_shoot_sfx()

func _physics_process(_delta: float) -> void:
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(30,30))
	
	# TIEMPO COOLDOWN BALA
	cooldown_shoot.wait_time = 0.1
	var player_direction := Vector2(0,0)
	
	# MOVILIDAD
	_movement()
	# ROTACION
	player_direction = _rotation()
	# ACCION DISPARAR
	if Input.is_action_pressed("Fire") and can_shoot:
		_shoot(player_direction)
	else:
		_particles(false)
		
func _on_timer_timeout() -> void:
	can_shoot = true
