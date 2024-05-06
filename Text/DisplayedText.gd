extends RichTextLabel


var earth_entry = 0;
var earth_exit = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_earth_atmosphere_body_entered(body):
	if earth_entry < 2:
		text = "Detonate the nuclear bomb you're carrying at the enemy planet to defeat the invaders!"
		earth_entry += 1
		print("aa")
	else:
		text = "Why are you coming back to Earth? Do your job!"


func _on_earth_atmosphere_body_exited(body):
	if earth_exit < 1:
		text = "Successful takeoff. Good luck on your mission!"
		earth_exit += 1
	else:
		text = "Do your job this time."


func _on_enemy_atmosphere_body_entered(body):
	text = "Detonate the bomb to save Earth!"


func _on_enemy_atmosphere_body_exited(body):
	text = "What are you doing? Do you want to leave your planet to die? Go back, and detonate the bomb!"
