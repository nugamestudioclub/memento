extends Node

@onready var world_timer: Timer = $WorldTimer
@onready var tree: SceneTree 



var items: Array[String] = []

func _on_world_timer_timeout() -> void:
	pass
	
signal inventory_changed

func add_item(item_name: String) -> void:
	items.append(item_name)
	inventory_changed.emit()


func remove_item(item_name: String) -> void:
	items.erase(item_name)  # removes the first match
	inventory_changed.emit()


func has_item(item_name: String) -> bool:
	return item_name in items


func count_item(item_name: String) -> int:
	return items.count(item_name)
