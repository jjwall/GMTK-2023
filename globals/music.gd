extends Node2D

func PlayMainMusic():
	if $Rock_Paper_Showdown_Main.playing:
		return
#	$Gravity_Way.stop()
	$Rock_Paper_Showdown_Main.play()
	print("Play Main Theme")
	
#func PlayGameplayMusic():
#	if $Gravity_Way.playing:
#		return
#
#	$Gravity_Shoppe.stop()
#	$Gravity_Way.play()
#
#	print("Play Way Theme")
