class_name Player extends RigidBody2D

const MY_ACCEL = 3000.0

var still_alive = true;
var fuel = 100.0
var fuel_rate = 50.0

func _integrate_forces(state):
	#print(AllObjects.player_location)
	var allPlanets = AllObjects.planets
	var force = Vector2(0,0)
	##print(get_parent().get_tree_string_pretty())
	for planet in allPlanets:
		if planet != self:
			
			var rigid_planet := planet as RigidBody2D
			var directionVector = rigid_planet.global_position - global_position
			#print(directionVector)
			#print(rigid_planet.global_position, global_position)
			#print(global_position)
			var distance = directionVector.length()
			
			
			var planetMass = rigid_planet.mass
			#if self.name.begins_with("Ea"):
				#print(directionVector)
			
			# if you are inside the other planet (i.e. distance between centers is less than radius of other planet), 
			# scale down the planetMass (shell theorem)
			if distance > 1e-5:
				if distance < rigid_planet.radius:
					planetMass *= pow(distance/rigid_planet.radius, 3)
				
				var thisForce = AllObjects.G * mass * planetMass * directionVector.normalized()/(distance * distance)
				#force += thisForce * directionVector.normalized()	
				##if self.name.begins_with("Ea"):
					##print(directionVector)
				#print(thisForce)
				force += thisForce
	
	
	
	if still_alive and fuel > 0:
		var direction = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")).normalized()
		fuel -= fuel_rate * direction.length() * state.get_step()
		force += mass * MY_ACCEL * direction
		AllObjects.fuel = max(fuel, 0)
	
	
	
	
	
	
	state.apply_force(force)
	AllObjects.player_location = global_position # so enemies magically know where you are
	


func _on_Player_body_entered(body):
	if body.name == "bullet":
		still_alive = false

func die():
	still_alive = false
	AllObjects.alive = false
	#queue_free()


#extends CharacterBody2D
#
#
#const SPEED = 120.0
#
#
## Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
#
#
#func _physics_process(delta):
#
	## Handle shooting.
	#if Input.is_action_just_pressed("ui_accept"):
		#spawn_bullet()
#
	## Get the input direction and handle the movement.
	#var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	#
	#velocity.x = direction.x * SPEED
	#velocity.y = direction.y * SPEED
#
	#move_and_slide()
	#
	## keep the spaceship inside the screen
	#if global_position.x < 16:
		#global_position.x = 16
	#elif global_position.x > 256 - 16:
		#global_position.x = 256 - 16
	#
	#if global_position.y < 16:
		#global_position.y = 16
	#elif global_position.y > 340 - 16:
		#global_position.y = 340 - 16
	#
	## handle animation
	#if velocity.x < 0:
		#$AnimatedSprite2D.play("left")
	#elif velocity.x > 0:
		#$AnimatedSprite2D.play("right")
	#else:
		#$AnimatedSprite2D.play("default")
		#
#func spawn_bullet():
	#var scene_to_spawn = preload("res://Bullet/bullet.tscn")
	#var new_scene_instance = scene_to_spawn.instantiate()
	#get_tree().current_scene.add_child(new_scene_instance)  # Add the instance as a child of the current scene
	#new_scene_instance.global_position = global_position
