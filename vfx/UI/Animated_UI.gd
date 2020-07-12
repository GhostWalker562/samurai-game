extends Control

func playTitle(title: String = "No Title"):
	print("Play")
	$PContainer/Title.text = title
	$AnimationPlayer.play("Play")
	
