extends Control

onready var ammo : Label = get_node("CenterContainer/HBoxContainer/Ammo");
onready var stamina : ProgressBar = get_node("CenterContainer/HBoxContainer/Stamina");

var ammo_text : String = "UNASSIGNED" ;
var stamina_percent : float = 0;

func _process(_delta):
	ammo.text = ammo_text;
	stamina.value = stamina_percent;
