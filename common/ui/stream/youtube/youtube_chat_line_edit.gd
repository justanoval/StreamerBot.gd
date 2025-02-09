extends LineEdit

func _ready() -> void:
	text_submitted.connect(_on_text_submitted)

func _on_text_submitted(new_text: String) -> void:
	if not new_text.is_empty():
		StreamerBot.do_action_from_name("SendYouTubeMessage", { "message": new_text })
		text = ""
