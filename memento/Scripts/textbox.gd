extends CanvasLayer

@onready var dialogue_label: Label = $MarginContainer/MarginContainer/HBoxContainer/Text
@onready var dialogue_end: Label = $MarginContainer/MarginContainer/HBoxContainer/End

var duration = 13
var dialogue_done = false
var tween: Tween
var marker_tween: Tween

func _ready():
	dialogue_end.modulate.a = 0
	display_dialogue("Hello! Welcome to the world of Pokemon. What is your name?")

func _input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_X:
		if not dialogue_done:
			if tween and tween.is_running():
				tween.kill()
			dialogue_label.visible_characters = -1
			dialogue_done = true
			animate_end_marker()

func display_dialogue(text_to_show: String):
	dialogue_label.text = text_to_show
	dialogue_label.visible_characters = 0
	dialogue_done = false

	tween = create_tween()
	tween.tween_property(dialogue_label, "visible_characters", text_to_show.length(), float(text_to_show.length()) / duration)

	tween.finished.connect(_on_dialogue_finished)

func _on_dialogue_finished():
	dialogue_done = true
	animate_end_marker()

func animate_end_marker():
	dialogue_end.modulate.a = 1

	if marker_tween and marker_tween.is_running():
		marker_tween.kill()

	marker_tween = create_tween().set_loops()
	marker_tween.tween_property(dialogue_end, "position:y", dialogue_end.position.y + 3, 0.8)
	marker_tween.tween_property(dialogue_end, "position:y", dialogue_end.position.y + 0, 0.8)
