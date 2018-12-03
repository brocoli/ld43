extends Node

export (int) var totalTime
export (float) var timePenalty
export (float) var timeBonus

var startTime

func _ready():
	startTime = OS.get_unix_time()
	set_clock_label(totalTime)

func _process(delta):
	var time = totalTime - (OS.get_unix_time() - startTime)
	if time >= 0:
		set_clock_label(time)
	else:
		get_tree().change_scene("res://scene/Endgame/TimesUp.tscn")

func set_clock_label(secs):
	$ClockFace.set_text("00:%02d" % secs)

func time_penalty():
	if timePenalty > 0:
		startTime -= timePenalty
		$"ClockFace/ColorTransition".penalty()

func time_bonus():
	if timeBonus > 0:
		startTime += timeBonus
		$"ClockFace/ColorTransition".bonus()
