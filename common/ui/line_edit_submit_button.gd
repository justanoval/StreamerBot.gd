extends Button

@export var line_edit: LineEdit

func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed() -> void:
	line_edit.text_submitted.emit(line_edit.text)
