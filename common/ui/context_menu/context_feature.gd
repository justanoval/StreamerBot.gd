extends Node

@export var button: Button
@export var menu: Control

func _ready() -> void:
	button.pressed.connect(self._on_pressed)

func _on_pressed() -> void:
	menu.visible = false
