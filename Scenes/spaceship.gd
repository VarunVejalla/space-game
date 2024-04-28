extends RigidBody2D

const MY_ACCEL = 3000.0

var still_alive = true;

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

#func _ready():
	#connect("body_entered", self, "_on_Player_body_entered")

func _integrate_forces(state):
	print(AllObjects.player_location)
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
	
	if !still_alive:
		direction = Vector2(0,0);
	
	force += mass * MY_ACCEL * direction
	
	
	
	state.apply_force(force)
	AllObjects.player_location = global_position
func _on_Player_body_entered(body):
	if body.name == "bullet":  # Assuming the projectiles are named "Projectile"
		still_alive = false
		queue_free()  # Destroy the player or handle the game over logic
