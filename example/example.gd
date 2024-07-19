extends StreamerBot

func _ready():
	# Connect to the websocket. 
	# You can change the port and ip if necessary like so:
	# self.connect_to_websocket(8080, "127.0.0.1")
	var err = self.connect_to_websocket()
	if err != OK:
		push_error("Websocket could not connect. Error: " % err)
	else:
		print("Connected!")
	
	# You must await the 'connected' signal if you are doing any actions
	# in the _ready() function.
	await connected
	
	# You can subscribe to an event and connect to a callable/function.
	# To see a list of events you can subscribe to, use the get_events() function.
	subscribe({"twitch": ["ChatMessage"]}, self._on_chat)
	
	# This assumes you have an action uniquely named "Test"
	# You can input args in the second parameter like so:
	# 	{"args":{"key":"value","key":"value"}}
	do_action_from_name("Test")

func _on_chat(response: Dictionary):
	var message_object = response.data.message
	print("%s: %s" % [ message_object.channel, message_object.message ])
