extends RigidBody2D


var firing_timer = 0.0
var firing_rate = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	firing_timer += delta
	if firing_timer >= firing_rate:
		firing_timer = 0.0
		fireProjectile()

func fireProjectile():
	var bullet = RigidBody2D.new()
	var shape = CollisionShape2D.new()
	bullet.gravity_scale = 0
	shape.shape = CircleShape2D.new()
	shape.shape.radius = 10  # Adjust the radius as needed
	bullet.add_child(shape)
	get_parent().add_child(bullet)
	bullet.name = "bullet"
	
	var direction = (AllObjects.player_location - global_position).normalized()
	bullet.global_position = global_position + direction * 5
	var bullet_speed = 100  # Adjust the speed as needed
	bullet.linear_velocity = direction * bullet_speed  # Set projectile speed based on your desired value
