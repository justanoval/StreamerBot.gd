extends StreamChatMessage

@onready var author_label: RichTextLabel = %AuthorLabel
@onready var message_label: RichTextLabel = %MessageLabel

var broadcaster_color: String = "#FF0033"
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
	self.author = payload.data.user.name
	
	if payload.data.user.isOwner:
		author = "[color=%s]%s[/color]" % [broadcaster_color, author]
	
	self.message = payload.data.message
	
	# Processing the message
	var modified_message = self.message

	# Process the emotes in reverse order
	for i in range(payload.data.emotes.size() - 1, -1, -1):
		var emote = payload.data.emotes[i]
		var image = await StreamerBot.load_image_from_url(emote.imageUrl)

		var start_index = emote.startIndex
		var end_index = emote.endIndex
		
		# Split the message into parts and insert the image
		var before = modified_message.substr(0, start_index + 1)
		var after = modified_message.substr(end_index + 2, modified_message.length() - end_index)
		var image_string = ("[img=%s]" % emote_size) + image.resource_path + "[/img]"
		
		modified_message = before + image_string + after
	
	message = modified_message
