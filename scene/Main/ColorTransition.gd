extends Tween

export (float) var period
export (float) var amplitude

func penalty():
	interpolate_method(
		get_node(".."),
		"set_font_color",
		Color(amplitude,0,0,1),
		Color(0,0,0,1),
		0.5 * period,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	start()

func bonus():
	interpolate_method(
		get_node(".."),
		"set_font_color",
		Color(0,amplitude,0,1),
		Color(0,0,0,1),
		0.5 * period,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT)
	start()