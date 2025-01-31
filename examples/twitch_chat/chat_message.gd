extends VBoxContainer

@onready var author_label: RichTextLabel = $Author
@onready var message_label: RichTextLabel = $Message

@onready var author: String:
	get(): return author
	set(value):
		author = value
		author_label.text = author

@onready var message: String:
	get(): return message
	set(value):
		message = value
		message_label.text = message

var emote_size: int = 20
var badge_size: int = 10

var message_id: String

func set_author(author_name: String, color: String):
	author = "[color=%s]%s[/color]" % [color, author_name]

func add_badge(texture: Texture2D) -> void:
	author += ("[img=%s]" % badge_size) + texture.resource_path + "[/img]"

func add_emote(start_index: int, end_index: int, texture: Texture2D) -> void:
	var before = message.substr(0, start_index)
	var after = message.substr(end_index + 1, message.length() - end_index)
	var image_string = ("[img=%s]" % emote_size) + texture.resource_path + "[/img]"
	message = before + image_string + after
