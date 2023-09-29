extends Node2D

func PlayMainMusic():
	if $Rock_Paper_Showdown_Main.playing:
		return
		
	$Rock_Paper_Showdown_Level.stop()
	$Rock_Paper_Showdown_Main.play()
	print("Play Main Theme")
	
func PlayLevelMusic():
	if $Rock_Paper_Showdown_Level.playing:
		return

	$Rock_Paper_Showdown_Main.stop()
	$Rock_Paper_Showdown_Level.play()

	print("Play Level Theme")
