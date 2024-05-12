extends CharacterBody3D

# Importante variaveis do Player Node
@onready var head = $head
@onready var standing_collision_shape = $standing_collision_shape
@onready var crounching_collision_shape = $crounching_collision_shape
@onready var ray_cast_3d = $RayCast3D

# Variaveis para controlar velocidade do movimento do player
var speed = 5.0
const walking_speed = 5.0
const sprint_speed = 8.
const crounching_speed = 3.

const jump_velocity = 4.5 # Velocidade do pulo
const mouse_sensibility = .25 # Sensibilidade do mouse

var lerp_speed = 10.

var direction = Vector3.ZERO

var crounching_depth = -.6

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-deg_to_rad(event.relative.x * mouse_sensibility))
		head.rotate_x(-deg_to_rad(event.relative.y * mouse_sensibility))
		head.rotation.x = clamp(head.rotation.x,deg_to_rad(-89),deg_to_rad(89))

func _physics_process(delta):
	
	if Input.is_action_pressed("crounch"):
		speed = crounching_speed
		head.position.y = lerp(head.position.y,(1.8 + crounching_depth),delta*lerp_speed)
		standing_collision_shape.disabled = true
		crounching_collision_shape.disabled = false
		
	elif !ray_cast_3d.is_colliding():
		standing_collision_shape.disabled = false
		crounching_collision_shape.disabled = true
		head.position.y = lerp(head.position.y,(1.8),delta*lerp_speed)
		
		if Input.is_action_pressed("sprint"):
			speed = sprint_speed
		else:
			speed = walking_speed

	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "foward", "backward")
	direction = lerp(direction,(transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized(), delta*lerp_speed)
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
