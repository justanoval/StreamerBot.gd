extends WebSocketConnection

signal custom_event(payload: String)
signal command_executed(payload: String)

var cache_dir: String = "user://cache/"
var cache = {}

var subbed_to_custom: bool = false
var subbed_to_commands: bool = false

var http_request: HTTPRequest

func _ready() -> void:
	if not DirAccess.dir_exists_absolute(cache_dir):
		DirAccess.make_dir_recursive_absolute(cache_dir)
	
	self.http_request = HTTPRequest.new()
	self.add_child(http_request)
	
	self.connected.connect(_on_connected)
	
	self.host = ProjectSettings.get_setting(
		"streamer_bot/websocket/host",
		"127.0.0.1")
	
	self.port = ProjectSettings.get_setting(
		"streamer_bot/websocket/port",
		8080)
	
	self.auto_reconnect = ProjectSettings.get_setting(
		"streamer_bot/websocket/auto_reconnect",
		true)
	
	var err = self.connect_to_websocket()
	if err != OK:
		push_error("Websocket could not connect. Error: " % err)

func _on_connected():
	print("Streamer.bot connected!")

## Image Cache

func get_response(http_request: HTTPRequest) -> Dictionary:
	var response = await http_request.request_completed
	return {
		"result": response[0],
		"response_code": response[1],
		"headers": response[2],
		"body": response[3]
	}

func download_image(url: String) -> Image:
	var http_error = http_request.request(url)
	if http_error != OK:
		push_error("An error occurred in the HTTP request.")
		return
	
	var response = await get_response(http_request)
	
	var image = Image.new()
	
	if image.load_jpg_from_buffer(response.body) == OK:
		pass
	elif image.load_png_from_buffer(response.body) == OK:
		pass
	elif image.load_bmp_from_buffer(response.body) == OK:
		pass
	elif image.load_ktx_from_buffer(response.body) == OK:
		pass
	elif image.load_svg_from_buffer(response.body) == OK:
		pass
	elif image.load_tga_from_buffer(response.body) == OK:
		pass
	elif image.load_webp_from_buffer(response.body) == OK:
		pass
	else:
		push_error("Couldn't load the image.")

	return image

func load_image_from_url(url: String) -> Texture2D:
	var path = _get_path_from_url(url)
	var image = _load_image_from_cache(path)
	
	if image == null:
		image = await download_image(url)
		image = _save_image_to_cache(image, path)
	
	return image

func _save_image_to_cache(image: Image, path: String) -> Texture2D:
	var error = image.save_png(path)
	if error != OK:
		push_error("There was an error saving the image to cache: " + str(error))
		return null
	else:
		var texture = ImageTexture.create_from_image(image)
		texture.take_over_path(path)
		cache[path] = texture
		return texture

func _load_image_from_cache(path: String) -> Texture2D:
	if cache.has(path):
		return cache[path]
	else:
		var file = FileAccess.open(path, FileAccess.READ)
		var error = FileAccess.get_open_error()
		
		if error == OK and file:
			var image = Image.new()
			var buffer = file.get_buffer(file.get_length())
			file.close()

			if image.load_png_from_buffer(buffer) == OK:
				var texture = ImageTexture.create_from_image(image)
				texture.take_over_path(path)
				cache[path] = texture
				return texture
		else:
			push_error("There was an error loading the image: " + str(error))
	
	return null

func _get_path_from_url(url: String) -> String:
	return cache_dir + url.sha1_text() + ".png"

func _path_local_to_global(path: String) -> String:
	return OS.get_user_data_dir() + path.substr(6, path.length())

## Streamer.bot

func get_unique_id() -> String:
	var date_string = str(Time.get_unix_time_from_system())
	return date_string.sha256_text()

func make_request(request: String, args: Dictionary = {}) -> Dictionary:
	var id = self.get_unique_id()
	var payload = {
		"request": request,
		"id": id
	}
	
	for key in args.keys():
		payload[key] = args[key]
	
	self.send_payload(payload)
	
	var response: Dictionary = await payload_received
	while not response.has("id") or not response.id == id:
		response = await payload_received
	
	return response

func subscribe(events: Dictionary, callable: Callable) -> Dictionary:
	var event_types = []
	for category in events:
		var event_list = events[category]
		event_types.append_array(event_list)
	
	var categories = []
	for category in events.keys():
		categories.append(category.to_lower())
	
	payload_received.connect(func(payload):
		if payload.has("event"):
			if categories.has(payload.event.source.to_lower()) and event_types.has(payload.event.type):
				callable.call(payload)
	)
	
	return await self.make_request("Subscribe", {"events": events})

func subscribe_to_custom(event: String, callable: Callable):
	if not subbed_to_custom:
		subscribe({"general": ["Custom"]}, func(response):
			custom_event.emit(response.data)
		)
		subbed_to_custom = true
	
	custom_event.connect(func(payload):
		if payload.event == event:
			callable.call(payload)
	)

func subscribe_to_command(commands: Array[String], callable: Callable):
	if not subbed_to_commands:
		subscribe({"command": ["Triggered"]}, func(response):
			command_executed.emit(response.data)
		)
	
	command_executed.connect(func(payload):
		if commands.has(payload.command):
			callable.call(payload)
	)

func unsubscribe(events: Dictionary) -> Dictionary:
	return await self.make_request("UnSubscribe", {"events": events})

func get_events() -> Dictionary:
	return await self.make_request("GetEvents")

func get_actions() -> Dictionary:
	return await self.make_request("GetActions")

func do_action(action: Dictionary, args: Dictionary = {}) -> Dictionary:
	return await self.make_request("DoAction", {"action": action, "args": args})

func do_action_from_name(action_name: String, args: Dictionary = {}) -> Dictionary:
	return await self.do_action({"name": action_name}, args)

func do_action_from_id(action_id: String, args: Dictionary = {}) -> Dictionary:
	return await self.do_action({"id": action_id}, args)

func get_broadcaster() -> Dictionary:
	return await self.make_request("GetBroadcaster")

func get_credits() -> Dictionary:
	return await self.make_request("GetCredits")

func test_credits() -> Dictionary:
	return await self.make_request("TestCredits")

func clear_credits() -> Dictionary:
	return await self.make_request("ClearCredits")
	
func get_info() -> Dictionary:
	return await self.make_request("GetInfo")

func get_active_viewers() -> Dictionary:
	return await self.make_request("GetActiveViewers")
