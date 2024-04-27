extends RigidBody2D

const MY_ACCEL = 3000.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#func _ready():
	#AllObjects.planets.append(self)

func _integrate_forces(state):
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
	
	var direction = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")).normalized()
	force += mass * MY_ACCEL * direction
	
	
	
	state.apply_force(force)

#func _physics_process(delta):
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept"):
		#
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction = Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
