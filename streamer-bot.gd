@tool
extends EditorPlugin

func _enter_tree() -> void:
	add_custom_type("StreamerBot", "Node", preload("streamer-bot.gd"), preload("icon.jpg"))

func _exit_tree() -> void:
	remove_custom_type("StreamerBot")
