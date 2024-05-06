extends Label

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	text = "Fuel remaining: " + str(round(AllObjects.fuel)) + "%"
	if not AllObjects.alive:
		text += "\nGame over! Try again."
	pass
