extends RigidBody2D

@export var radius : float
@export var velocity : Vector2
@export var color : Color
@export var orbit : Vector2 # point that it will orbit around
@export var orbit_time : float # time for one rotation

# orbit stuff is so planets have nice orbits unlike with "real" gravity

#mass is already a variable in RigidBody2D

func _draw():
	draw_circle(Vector2(0,0), radius, color)	

# Called when the node enters the scene tree for the first time.
func _ready():
	print(radius)
	linear_velocity = velocity
	AllObjects.planets.append(self)
	#set_physics_process(true)
	var collision_shape = get_node("PlanetBody")
	var planet_body = CircleShape2D.new()
	planet_body.radius = radius
	collision_shape.shape = planet_body
	gravity_scale = 0 # fuck gravity

func _process(delta):
	if orbit_time > 0.001: #for convenience
		var delta_position = position - orbit
		var angle = atan2(delta_position.y, delta_position.x)
		angle = 2*PI/orbit_time * delta
		position = orbit + (position-orbit).rotated(angle)
	
	
	#update_position()
	
	

#func _integrate_forces(state):
	#var allPlanets = AllObjects.planets
	#var force = Vector2(0,0)
	###print(get_parent().get_tree_string_pretty())
	#for planet in allPlanets:
		#if planet != self:
			#
			#var rigid_planet := planet as RigidBody2D
			#var directionVector = rigid_planet.global_position - global_position
			##print(directionVector)
			##print(rigid_planet.global_position, global_position)
			##print(global_position)
			#var distance = directionVector.length()
			#
			#
			#var planetMass = rigid_planet.mass
			##if self.name.begins_with("Ea"):
				##print(directionVector)
			#
			## if you are inside the other planet (i.e. distance between centers is less than radius of other planet), 
			## scale down the planetMass (shell theorem)
			#if distance > 1e-5:
				#if distance < rigid_planet.radius:
					#planetMass *= pow(distance/rigid_planet.radius, 3)
				#
				#var thisForce = AllObjects.G * mass * planetMass * directionVector.normalized()/(distance * distance)
				##force += thisForce * directionVector.normalized()	
				###if self.name.begins_with("Ea"):
					###print(directionVector)
				##print(thisForce)
				#force += thisForce
	#
	#state.apply_force(force)
