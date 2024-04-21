extends RigidBody2D

@export var radius : float
@export var velocity : Vector2
@export var color : Color
#@export var is_center : bool

#var oldFlag = true
#var flag = true

#mass is already a variable in RigidBody2D

func _draw():
	draw_circle(Vector2(0,0), radius, color)	

# Called when the node enters the scene tree for the first time.
func _ready():
	linear_velocity = velocity
	AllObjects.planets.append(self)
	#set_physics_process(true)
	$CollisionShape2D.shape.radius = radius
	gravity_scale = 0
	#if is_center:
		#AllObjects.center = self
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _physics_process(delta):
	#pass

#func _process(delta):
	#queue_redraw()

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
	
	state.apply_force(force)
