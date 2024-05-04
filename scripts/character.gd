extends CharacterBody2D
@export_category("Variables")
@export var _move_speed: float = 64.0
func _physics_process(_delta: float)-> void:
	_move()
func _move() -> void:
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left","move_rigth"),
		Input.get_axis("move_up","move_down")
	)
	velocity = _direction.normalized() * _move_speed
	move_and_slide()
