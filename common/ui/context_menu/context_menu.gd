extends BoxContainer
class_name ContextMenu

@export var parent: Control
@export var mouse_button: MouseButton = MOUSE_BUTTON_RIGHT

func _ready() -> void:
	visible = false
	parent.gui_input.connect(self._button_gui_input)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if not get_global_rect().has_point(get_global_mouse_position()):
			visible = false

func _button_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if event.button_mask == mouse_button:
			visible = true
			global_position = get_global_mouse_position() - Vector2(0, size.y)
