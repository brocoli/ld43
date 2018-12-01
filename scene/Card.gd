extends Area2D
signal hit

var lifted = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton and not event.pressed:
		lifted = false
	if lifted and event is InputEventMouseMotion:
		position += event.relative

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		lifted = true