
extends CanvasLayer

@onready var timer: Timer = $Timer
@onready var timer_label: Label = $Label

var fade_tween: Tween
var tab_was_pressed := false

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	timer_label.text = "30"
	timer.start()
	timer_label.modulate.a = 0.0

func _process(_delta):
	timer_label.text = str(ceil(timer.time_left))

	var tab_pressed = Input.is_key_pressed(KEY_TAB)

	if tab_pressed != tab_was_pressed:
		tab_was_pressed = tab_pressed

		if fade_tween and fade_tween.is_running():
			fade_tween.kill()

		fade_tween = create_tween()

		if tab_pressed:
			fade_tween.tween_property(timer_label, "modulate:a", 1.0, 0.25)
		else:
			fade_tween.tween_interval(1.5)
			fade_tween.tween_property(timer_label, "modulate:a", 0.0, 0.5)

func _on_timer_timeout():
	timer.start()
