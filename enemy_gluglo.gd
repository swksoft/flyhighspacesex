extends CharacterBody2D

@onready var animation: AnimationPlayer = $AnimationPlayer
@onready var colision: CollisionShape2D = $AreaSearch/CollisionShape2D
@onready var cooldown: Timer = $Cooldown
@onready var attack: Timer = $Attack

var found: bool = false
var prepare: bool = false
var fire: bool = false
var recovery: bool = false

var player_scene: PackedScene = preload("res://scripts/player.tscn")

var speed: int = 150
#const SPEED: int = 150 #!
var direction := Vector2.LEFT

var player_position = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var player = player_scene.instantiate() as CharacterBody2D
	#raycast.look_at(player.position)
	#raycast.rotation_degrees = rad_to_deg(player.global_position.angle())
	#raycast.target_position = player.global_position
	#raycast.target_position = player.get_target_position
	
	if found:
		colision.disabled = true
		#rotation_degrees = rad_to_deg(90)
		look_at(player_position)
		rotation_degrees = rad_to_deg(-90)
		#look_at(player_position)
		#rotation_degrees = rad_to_deg(player_position.angle())
		#position += player_position * (speed*1.5) * delta # Linea innecesaria?
		#$Sprite2D.look_at(player.global_position)
		#$Sprite2D.look_at(player.global_position + direction)
		if global_position == Vector2(int(player_position.x), int(player_position.y)):
			colision.disabled = false
			found = false
			cooldown.start()
		else:
			attack.start()
			position = global_position.move_toward(player_position, delta * speed)
			print(global_position)	
	else:
		rotation_degrees = 0
		colision.disabled = false
		position += direction * speed * delta
		
	move_and_slide
		

func _on_area_cuerpo_area_entered(area: Area2D) -> void:
	print("Ouch!")

func _on_area_coraza_area_entered(area: Area2D) -> void:
	print("Bloqueo!")

func _on_area_search_body_entered(body: Node2D) -> void:
	print("cagaste!")
	player_position = Vector2(int(body.position.x), int(body.position.y))
	print(player_position)
	found = true

func _on_cooldown_timeout() -> void:
	found = false
	colision.disabled = false
	print("pollas")


func _on_attack_timeout() -> void:
	position += Vector2.ZERO
