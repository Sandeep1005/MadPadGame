extends KinematicBody


# Declare member variables here. Examples:
var velocity = Vector3.ZERO
const SPEED = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _physics_process(delta):
	if Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
	elif Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
	else:
		velocity.x = lerp(velocity.x, 0, 0.3)
	move_and_slide(velocity)
