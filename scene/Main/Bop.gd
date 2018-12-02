extends Tween

export (float) var period
export (float) var amplitude

func bop():
	connect("tween_completed", self, "_unbop")
	interpolate_method(
		get_node(".."),
		"set_scale",
		Vector2(1,1),
		Vector2(amplitude, amplitude),
		0.5 * period,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	start()

func _unbop(obj, key):
	disconnect("tween_completed", self, "_unbop")
	interpolate_method(
		get_node(".."),
		"set_scale",
		Vector2(amplitude, amplitude),
		Vector2(1,1),
		0.5 * period,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	start()