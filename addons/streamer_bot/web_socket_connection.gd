extends Node
class_name WebSocketConnection

signal connected
signal closed
signal packet_received(packet: PackedByteArray)
signal payload_received(payload: Dictionary)

var socket = WebSocketPeer.new()
var is_connected: bool = false
var auto_reconnect: bool = true

var host: String = "127.0.0.1"
var port: int = 8080

func _process(_delta) -> void:
	socket.poll()
	
	var state = socket.get_ready_state()
	
	if state == WebSocketPeer.STATE_OPEN:
		if not is_connected:
			print("Websocket connected!")
			is_connected = true
			connected.emit()
		
		while socket.get_available_packet_count():
			var packet = socket.get_packet()
			_on_packet_received(packet)
			packet_received.emit(packet)
	elif state == WebSocketPeer.STATE_CONNECTING:
		pass
	elif state == WebSocketPeer.STATE_CLOSING:
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		closed.emit()
		var code = socket.get_close_code()
		var reason = socket.get_close_reason()
		print("WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
		
		if self.auto_reconnect:
			is_connected = false
			print("Reconnecting...")
			connect_to_websocket()
		else:
			print("WebSocket auto_reconnect is set to false, not reconnecting.")
			set_process(false)

func _on_packet_received(packet: PackedByteArray) -> void:
	var packet_string = packet.get_string_from_utf8()
	var payload = JSON.parse_string(packet_string)
	
	if payload:
		payload_received.emit(payload)

func _get_address(host: String, port: int) -> String:
	return "ws://%s:%s/" % [ host, port ]

func connect_to_websocket(_port: int = port, _host: String = host) -> Error:
	self.host = _host
	self.port = _port
	return socket.connect_to_url(self._get_address(host, port))

func close_connection():
	socket.close()

func send_payload(payload: Dictionary) -> void:
	if not is_connected:
		await connected
	
	self.socket.send_text(JSON.stringify(payload))
