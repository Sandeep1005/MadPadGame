extends KinematicBody


# Declare member variables here. Examples:
var velocity = Vector3(0,0,0)
var SPEED = 25
var startTime = OS.get_ticks_usec()

var rand_generator = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	rand_generator.randomize()
	var theta = rand_generator.randf_range(PI, 2*PI)
	velocity.x = SPEED*cos(theta)
	velocity.z = SPEED*sin(theta)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var collision = move_and_collide(velocity*delta)
	if collision:
		var n = collision.normal
		var newVelocity = Vector3.ZERO
		newVelocity.x = velocity.x - 2*n.x*(n.x*velocity.x + n.y*velocity.y + n.z*velocity.z)
		newVelocity.y = velocity.y - 2*n.y*(n.x*velocity.x + n.y*velocity.y + n.z*velocity.z)
		newVelocity.z = velocity.z - 2*n.z*(n.x*velocity.x + n.y*velocity.y + n.z*velocity.z)
		velocity = newVelocity
		
	if (OS.get_ticks_usec() - startTime) > 5000000:
		var theta = rand_generator.randf_range(0, 2*PI)
		velocity.x = SPEED*cos(theta)
		velocity.z = SPEED*sin(theta)
		
		startTime = OS.get_ticks_usec()


func _on_Area_body_entered(body):
	get_tree().change_scene("res://scenes/gameOverScene.tscn")
