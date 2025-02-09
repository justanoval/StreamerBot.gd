extends BoxContainer

@export var max_load: int = 100

func _ready() -> void:
	child_entered_tree.connect(_on_child_entered_tree)

func _on_child_entered_tree(child: Node):
	if get_child_count() > max_load:
		remove_child(get_child(0))
