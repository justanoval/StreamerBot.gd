extends ScrollContainer
class_name AutoScrollContainer

@onready var scroll_bar = get_v_scroll_bar()

var _max_scroll_length: int
var _current_scroll_length: int

func _ready() -> void:
	scroll_bar.changed.connect(_on_scrollbar_changed)
	scroll_bar.scrolling.connect(_on_scrolling)
	_max_scroll_length = scroll_bar.max_value

func _on_scrollbar_changed():
	var at_bottom = _current_scroll_length == _max_scroll_length
	
	if _max_scroll_length != scroll_bar.max_value:
		_max_scroll_length = scroll_bar.max_value

		if at_bottom or scroll_vertical == 0:
			scroll_vertical = _max_scroll_length
			_current_scroll_length = _max_scroll_length

func _on_scrolling() -> void:
	_current_scroll_length = scroll_bar.value + scroll_bar.page
