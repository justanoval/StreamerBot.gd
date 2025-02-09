extends Control
class_name StreamChatMessage

@onready var timestamp_label: Label = %TimestampLabel

func build(payload: Dictionary) -> void:
	var time: Dictionary = Time.get_datetime_dict_from_datetime_string(payload.timeStamp, false)
	timestamp_label.text = "%02d:%02d" % [time.hour, time.minute]
