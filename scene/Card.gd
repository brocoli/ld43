extends RigidBody2D
signal hit

export (PackedScene) var TouchDragPhysics

var draggableBody = null
var dragJoint = null

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton and not event.pressed:
		drop()
	if (draggableBody != null) and event is InputEventMouseMotion:
		draggableBody.position += event.relative

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		lift()

func lift():
	draggableBody = TouchDragPhysics.instance()
	draggableBody.position = self.position
	get_parent().add_child(draggableBody)
	
	dragJoint = PinJoint2D.new()
	dragJoint.set_node_a(draggableBody.get_path())
	dragJoint.set_node_b(get_path())
	get_parent().add_child(dragJoint)

func drop():
	dragJoint.queue_free()
	dragJoint = null
	
	get_parent().remove_child(draggableBody)
	draggableBody = null
