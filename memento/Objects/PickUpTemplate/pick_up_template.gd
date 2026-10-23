extends Area2D

signal picked_up

@export var item_name := "Item"
@export var interact_text := "Press E"
@export var show_message := true
@export_multiline var pickup_message := "You picked it up"

@onready var prompt: Label = $PromptLabel

var player_in_range := false


func _ready() -> void:
	prompt.text = interact_text
	prompt.hide()
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = true
		prompt.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_in_range = false
		prompt.hide()


func _unhandled_input(event: InputEvent) -> void:
	if player_in_range and event.is_action_pressed("Interact"):
		pick_up()


func pick_up() -> void:
	var dialogue_box = get_tree().get_first_node_in_group("dialogue")

	if dialogue_box and dialogue_box.visible:
		return

	Globals.add_item(item_name)
	picked_up.emit()

	if show_message and dialogue_box:
		dialogue_box.display_dialogue(pickup_message)

	queue_free()
