extends AudioStreamPlayer2D

export (float) var playFrom

func play_correctly():
	play(playFrom)
