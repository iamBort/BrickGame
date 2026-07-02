extends Area2D

var game_manager: Node

func _ready() -> void:
	game_manager = get_node("%GameManager")
	

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("DeadzoneInteract") and body.has_method("Delete"):
		body.Delete()
