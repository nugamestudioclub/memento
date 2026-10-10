
extends CanvasLayer

@onready var dialogue_label: Label = $MarginContainer/MarginContainer/HBoxContainer/Label2
var duration = 13
var tween: Tween

func _ready():
	display_dialogue("heeokapkfpaoi oaopsk opakpoa")

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_X:
		if dialogue_label.visible_characters < dialogue_label.text.length():
			tween.kill()
			dialogue_label.visible_characters = -1

func display_dialogue(text_to_show: String):
	dialogue_label.text = text_to_show
	dialogue_label.visible_characters = 0

	tween = create_tween()
	tween.tween_property(
		dialogue_label,
		"visible_characters",
		text_to_show.length(),
		text_to_show.length() / duration
	)
