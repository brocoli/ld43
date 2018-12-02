extends Tween

export (float) var period
export (float) var amplitude

func shake_screen():
	connect("tween_completed", self, "_shake_right")
	interpolate_property(
		get_node(".."),
		"position",
		Vector2(0,0),
		Vector2(-amplitude,0),
		0.5 * period,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	start()

func _shake_right(obj, key):
	disconnect("tween_completed", self, "_shake_right")
	connect("tween_completed", self, "_shake_left")
	interpolate_property(
		get_node(".."),
		"position",
		Vector2(-amplitude,0),
		Vector2(amplitude,0),
		period,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	start()

func _shake_left(obj, key):
	disconnect("tween_completed", self, "_shake_left")
	connect("tween_completed", self, "_shake_back")
	interpolate_property(
		get_node(".."),
		"position",
		Vector2(amplitude,0),
		Vector2(-amplitude,0),
		period,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	start()

func _shake_back(obj, key):
	disconnect("tween_completed", self, "_shake_back")
	interpolate_property(
		get_node(".."),
		"position",
		Vector2(-amplitude,0),
		Vector2(0,0),
		period,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	start()
