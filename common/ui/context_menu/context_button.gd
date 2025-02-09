extends Button
class_name ContextButton

@export var menu: Control

func _ready() -> void:
	pressed.connect(self._on_pressed)

func _on_pressed() -> void:
	menu.visible = false
