extends Area2D

signal interacted

@export var interact_text := "Press E"
@export_multiline var message := "Hello! This is a default message."

@onready var prompt: Label = $PromptLabel

var player_in_range := false


func _ready() -> void:
	prompt.text = interact_text
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
		interact()


func interact() -> void:
	var dialogue_box = get_tree().get_first_node_in_group("dialogue")

	if dialogue_box == null or dialogue_box.visible:
		return

	dialogue_box.display_dialogue(message)
	interacted.emit()
