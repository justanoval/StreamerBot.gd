extends WebSocketConnection
class_name StreamerBot

signal custom_event(payload: String)
signal command_executed(payload: String)

var subbed_to_custom: bool = false
var subbed_to_commands: bool = false

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
	
	var response = await payload_received
	while not response.id == id:
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
