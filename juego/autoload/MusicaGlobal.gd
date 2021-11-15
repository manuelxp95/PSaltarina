extends Node

func replay():
	$Boss.stop()
	$AudioStreamPlayer.stop()
	$AudioStreamPlayer.play()

func stop_music():
	$AudioStreamPlayer.stop()
	
func boss_song():
	$AudioStreamPlayer.stop()
	$Boss.play()
