extends CharacterBody3D

const speed = 5.0
const jumpVel = 4.5
const mouseSensitivity = 0.001
const mouseRange = 1.2

# Get Gravity
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

# Handle Mouse Movement
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Pivot.rotate_x(-event.relative.y * mouseSensitivity)
		$Pivot.rotation.x = clamp($Pivot.rotation.x, -mouseRange, mouseRange)
		rotate_y(-event.relative.x * mouseSensitivity)

func _physics_process(delta):
	if !is_on_floor():
		velocity.y -= gravity * delta
		
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = jumpVel
		
	var inputDir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(inputDir.x, 0, inputDir.y)).normalized()
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
