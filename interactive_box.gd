extends InteractiveContainer

var rotation_velocity = randf_range(-5.0,-5.0)

func _ready():
	sprite.rotation_degrees = randf_range(0, 360)
	
func _process(delta):
	sprite.rotation_degrees += rotation_velocity * delta


