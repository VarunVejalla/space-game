extends RigidBody2D

var speed = 70

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

		
func spawn_bullet():
	var scene_to_spawn = preload("res://Bullet/bullet.tscn")
	var new_scene_instance = scene_to_spawn.instantiate()
	get_tree().current_scene.add_child(new_scene_instance)  # Add the instance as a child of the current scene
	new_scene_instance.global_position = global_position

func fireProjectile():
	
	var scene_to_spawn = preload("res://Bullet/bullet.tscn")
	var new_scene_instance = scene_to_spawn.instantiate()
	get_tree().current_scene.add_child(new_scene_instance)  # Add the instance as a child of the current scene
	#new_scene_instance.global_position = global_position
	new_scene_instance.gravity_scale = 0
	
	
	var direction = (AllObjects.player_location - global_position).normalized()
	new_scene_instance.global_position = global_position + direction * 5
	new_scene_instance.linear_velocity = direction * new_scene_instance.speed
