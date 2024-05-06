extends Label3D

var dinheiro = 0.;

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Dinheiro %s" % dinheiro


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pular"):
		# Espaço pressionado detectado
		dinheiro += 1
		text = "Dinheiro %s" % dinheiro
