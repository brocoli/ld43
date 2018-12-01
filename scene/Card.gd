extends RigidBody2D
signal hit

export (PackedScene) var TouchDragPhysics

var draggableBody = null

func _unhandled_input(event):
	if event is InputEventMouseButton and not event.pressed and draggableBody != null:
		drop()
	if (draggableBody != null) and event is InputEventMouseMotion:
		draggableBody.position += event.relative

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and draggableBody == null:
		lift()

func lift():
	draggableBody = TouchDragPhysics.instance()
	draggableBody.position = get_viewport().get_mouse_position()
	get_parent().add_child(draggableBody)
	
	var joint = draggableBody.get_node("PinJoint2D")
	joint.set_node_b(get_path())

func drop():
	get_parent().remove_child(draggableBody)
	draggableBody = null
