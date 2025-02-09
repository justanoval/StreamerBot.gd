extends StreamChatMessage
class_name TwitchChatMessage

@onready var author_label: RichTextLabel = %AuthorLabel
@onready var message_label: RichTextLabel = %MessageLabel

var message_id: String
var emote_size: int = 20
var badge_size: int = 10

var author: String:
	get(): return author
	set(value):
		author = value
		author_label.text = author

var message: String:
	get(): return message
	set(value):
		message = value
		message_label.text = message

func build(payload: Dictionary) -> void:
	super.build(payload)
	self.message_id = payload.data.message.msgId
	self.message = payload.data.message.message
	self.set_author(payload.data.message.displayName, payload.data.message.color)
	
	for badge in payload.data.message.badges:
		var image = await StreamerBot.load_image_from_url(badge.imageUrl)
		self.add_badge(image.resource_path)
	
	# Processing the message
	var modified_message = self.message

	# Process the emotes in reverse order
	for i in range(payload.data.message.emotes.size() - 1, -1, -1):
		var emote = payload.data.message.emotes[i]
		var image = await StreamerBot.load_image_from_url(emote.imageUrl)

		var start_index = emote.startIndex
		var end_index = emote.endIndex
		
		# Split the message into parts and insert the image
		var before = modified_message.substr(0, start_index)
		var after = modified_message.substr(end_index + 1, modified_message.length() - end_index)
		var image_string = ("[img=%s]" % emote_size) + image.resource_path + "[/img]"
		
		modified_message = before + image_string + after
	
	message = modified_message

func set_author(author_name: String, color: String) -> void:
	author = "[color=%s]%s[/color]" % [color, author_name]

func add_badge(path: String) -> void:
	author = author + " " + ("[img=%s]" % badge_size) + path + "[/img]"
