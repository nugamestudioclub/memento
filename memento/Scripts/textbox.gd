
extends CanvasLayer

@onready var dialogue_label: Label = $MarginContainer/MarginContainer/HBoxContainer/Text
@onready var dialogue_end: Sprite2D = $MarginContainer/MarginContainer/HBoxContainer/End

var duration = 13.0
var dialogue_done = false
var tween: Tween
var marker_tween: Tween

var dialogue_text = "Hello! This is your first dialogue."


func _ready():
	hide()

	dialogue_end.visible = true
	dialogue_end.modulate.a = 0

func display_dialogue(text_to_show: String):
	show()

	if tween and tween.is_running():
		tween.kill()

	if marker_tween and marker_tween.is_running():
		marker_tween.kill()

	dialogue_end.modulate.a = 0

	dialogue_label.text = text_to_show
	dialogue_label.visible_characters = 0
	dialogue_done = false

	tween = create_tween()
	tween.tween_property(
		dialogue_label,
		"visible_characters",
		text_to_show.length(),
		float(text_to_show.length()) / duration
	)

	tween.finished.connect(_on_dialogue_finished)


func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:

		if event.keycode == KEY_SPACE:
			if not visible:
				display_dialogue(dialogue_text)
			return

		if event.keycode == KEY_X:
			if not visible:
				return

			if not dialogue_done:
				if tween and tween.is_running():
					tween.kill()

				dialogue_label.visible_characters = -1
				dialogue_done = true
				animate_end_marker()


func _on_dialogue_finished():
	dialogue_done = true
	animate_end_marker()


func animate_end_marker():
	dialogue_end.modulate.a = 1

	if marker_tween and marker_tween.is_running():
		marker_tween.kill()

	var start_y = dialogue_end.position.y

	marker_tween = create_tween().set_loops()
	marker_tween.tween_property(
		dialogue_end, "position:y", start_y + 3, 0.8
	)
	marker_tween.tween_property(
		dialogue_end, "position:y", start_y, 0.8
	)


func close_dialogue():
	if tween and tween.is_running():
		tween.kill()

	if marker_tween and marker_tween.is_running():
		marker_tween.kill()

	dialogue_end.modulate.a = 0

	hide()
