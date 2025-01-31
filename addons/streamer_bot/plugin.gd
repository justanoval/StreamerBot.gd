@tool
extends EditorPlugin

func _enter_tree() -> void:
	# Add websocket IP
	_define_project_setting(
		"streamer_bot/websocket/host",
		TYPE_STRING,
		PROPERTY_HINT_NONE,
		"",
		"127.0.0.1")
	
	# Add websocket port
	_define_project_setting(
		"streamer_bot/websocket/port",
		TYPE_INT,
		PROPERTY_HINT_NONE,
		"",
		8080)
	
	# Add websocket auto reconnect
	_define_project_setting(
		"streamer_bot/websocket/auto_reconnect",
		TYPE_BOOL,
		PROPERTY_HINT_NONE,
		"",
		true)
	
	add_autoload_singleton("StreamerBot", "res://addons/streamer_bot/streamer_bot.gd")
	add_autoload_singleton("Twitch", "res://addons/streamer_bot/twitch/twitch.gd")
	add_autoload_singleton("YouTube", "res://addons/streamer_bot/youtube/youtube.gd")

func _exit_tree() -> void:
	remove_autoload_singleton("StreamerBot")
	remove_autoload_singleton("Twitch")
	remove_autoload_singleton("YouTube")

func _define_project_setting(
	p_name: String,
	p_type: int,
	p_hint: int = PROPERTY_HINT_NONE,
	p_hint_string: String = "",
	p_default_val = ""
) -> void:
	if !ProjectSettings.has_setting(p_name):
		ProjectSettings.set_setting(p_name, p_default_val)

	var property_info : Dictionary = {
		"name": p_name,
		"type": p_type,
		"hint": p_hint,
		"hint_string": p_hint_string
	}

	ProjectSettings.add_property_info(property_info)
	
	if ProjectSettings.has_method("set_as_basic"):
		ProjectSettings.call("set_as_basic", p_name, true)
	
	ProjectSettings.set_initial_value(p_name, p_default_val)
	ProjectSettings.save()
