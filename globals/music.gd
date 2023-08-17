extends Node2D

func PlayMainMusic():
	if $Green_Pastures.playing:
		return
#	$Gravity_Way.stop()
	$Green_Pastures.play()
	print("Play Main Theme")
	
#func PlayGameplayMusic():
#	if $Gravity_Way.playing:
#		return
#
#	$Gravity_Shoppe.stop()
#	$Gravity_Way.play()
#
#	print("Play Way Theme")
