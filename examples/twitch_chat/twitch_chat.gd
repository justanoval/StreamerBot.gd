extends Node

const CHAT_MESSAGE = preload("res://examples/twitch_chat/chat_message.tscn")

@onready var chat_message_container: VBoxContainer = %ChatMessageContainer
@onready var scroll_container: ScrollContainer = %ScrollContainer
@onready var http_request: HTTPRequest = $HTTPRequest

var cache_path = "user://streamer_bot/cache"

func _ready():
	# You can connect the chat_message event directly from the
	# Twitch ssingleton
	Twitch.chat_message.connect(self._on_chat_message_sent)
	
	# This assumes you have an action uniquely named "Test"
	# You can input args in the second parameter like so:
	# 	{"args":{"key":"value","key":"value"}}
	StreamerBot.do_action_from_name("Test")

func _on_chat_message_sent(payload: Dictionary):
	var chat_message = CHAT_MESSAGE.instantiate()
	chat_message_container.add_child(chat_message)
	
	var data = payload.data
	
	# I like to set the message ID so that deleting messages is 
	# easier, if you want to make that compatible.
	chat_message.message_id = data.message.msgId
	chat_message.message = data.message.message
	
	chat_message.set_author(
		data.user.name,
		data.user.color)
	
	# Below I use a function to download the images,
	# but it'd be much better to use a caching system in
	# actual application
	
	for badge in payload.data.message.badges:
		var texture = await get_texture(badge.imageUrl)
		chat_message.add_badge(texture)
	
	for emote in payload.data.message.emotes:
		var texture = await get_texture(emote.imageUrl)
		chat_message.add_emote(emote.startIndex, emote.endIndex, texture)

func get_texture(url: String):
	var path = cache_path + "/" + url.sha1_text() + ".png"
	
	var image
	if FileAccess.file_exists(path):
		image = Image.load_from_file(path)
	else:
		image = await download_image(url)
		image.save_png(path)
	
	var texture = ImageTexture.create_from_image(image)
	texture.take_over_path(path)
	return texture

func download_image(url: String) -> Image:
	var http_error = http_request.request(url)
	if http_error != OK:
		push_error("An error occurred in the HTTP request.")
		return
	
	var response = await http_request.request_completed
	var body = response[3]
	
	var image = Image.new()
	
	if not image.load_png_from_buffer(body) == OK:
		push_error("Couldn't load the image.")
	
	return image
