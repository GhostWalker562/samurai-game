extends Control

func playTitle(title: String = "No Title"):
	$PContainer/Title.text = title
	$AnimationPlayer.play("Play")
	
func playWin(title: String = "No Title"):
	$PContainer/Title.text = title
	$AnimationPlayer.play("Win")
		
