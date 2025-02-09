extends Node

const CHAT_MESSAGE = preload("res://common/ui/stream/twitch/twitch_chat_message.tscn")

@export var chat_container: Control

func _ready() -> void:
	Twitch.chat_message.connect(self._on_chat_message)
	Twitch.chat_message_deleted.connect(self._on_chat_message_deleted)

func _on_chat_message(payload):
	var chat_message = CHAT_MESSAGE.instantiate()
	chat_container.add_child(chat_message)
	chat_message.build(payload)

func _on_chat_message_deleted(payload):
	for child in chat_container.get_children():
		if child is TwitchChatMessage:
			if child.message_id == payload.data.messageId:
				child.queue_free()
				return
