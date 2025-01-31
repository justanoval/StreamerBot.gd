An addon for Godot 4 to interact with Streamer.bot.

# About
This addon was made by [justan oval](https://justanoval.com/): I make interactive streams over on [my Twitch](https://www.twitch.tv/justanoval), and everything is made in **Godot Engine**!

I've made many utilities along my development journey to make this easier for myself. I figured I can make these tools available for others that aspire to make interactive streams as well.

# Installation
1. Download the latest release in [the releases tab](https://github.com/justanoval/StreamerBot.gd/releases).
2. Unzip the files.
3. Put the files from `/addons/streamer_bot` into `res://addons/streamer_bot/`, or simply drag the folder into `res://`.

# Getting started
First, make sure your Websocket Server is on. You can enable this in the `Servers/Clients` tab under `Websocket Server` (not `Websocket Servers`). It should look like this:
![image](https://github.com/user-attachments/assets/61ba3be5-88f3-4f84-9cec-1b40b59c2564)

You can change the address and port if you'd ilke to.

Then, in Godot Engine, go to your Project Settings under the Streamer Bot section:
![image](https://github.com/user-attachments/assets/1e4b471c-80e3-4fdc-a905-06796d13dd4b)

There, you can configure your settings. They should match up to your Streamer.bot host and port.

It is recommended against disabling `auto_reconnect`. Oftentimes the websocket may close at random, and this will have it reboot with no issues.

# Subscribing to events
StreamerBot.gd adds three new autoloads:
- `StreamerBot`
- `Twitch`
- `YouTube`

All Twitch and YouTube events are ran through signals. To connect, all you need to do is connect it like you would any other signal:
```gdscript
func _ready() -> void:
  Twitch.chat_message.connect(self._on_chat_message)

func _on_chat_message(payload: Dictionary) -> void:
  print(payload)
```

The primary caveat right now is that **you will have to print out the payload** and go through it yourself. They're much too large and dynamic, so I have yet to create their own objects for them, but that will come soon.

For now, you can use my favorite JSON reader, [json.fans](https://json.fans/).

To subscribe to any other event not from Twitch or YouTube, you can do it through `StreamerBot`. However, unlike using `Twitch` or `YouTube`, you have to first await the `StreamerBot.connected` signal. 
This is due to the websocket periodic resetting I had mentioned last time--if you subscribe to it in the `_ready` function, then when the websocket reconnects, the subscribe events will not. The `Twitch` and `YouTube` singletons do this already, so you only have 
to worry about it with others.

You can subscribe to an event similarily to using a signal:
```gdscript
func _ready() -> void:
  StreamerBot.connected.connect(self._on_streamer_bot_connected)

func _on_streamer_bot_connected() -> void:
  StreamerBot.subscribe({"twitch":["ChatMessage"]}, self._on_chat_message)

func _on_chat_message(payload: Dictionary) -> void:
  print(payload)
```

Below is the formart:
```gdscript
subscribe({"<event category>":["<event name>", "<event name>"]}, self.callback)
```

Each action comes with a response, so if you'd like to check if it actually subscribes, you can do that like so:
```gdscript
var response = await StreamerBot.subscribe({"twitch":["ChatMessage"]}, self._on_chat_message)
if response.status == "ok":
  print("Subscribed")
else response.status == "error":
  push_error("Failed to subscribe")
```

## Finding available events
The best way to find available events is by using the `get_events()` function
```gdscript
print(await StreamerBot.get_events())
```
This will give a rather _massive_ list. I'd recommend using a [JSON formatter](https://json.fans/) to read them all.

# Unsubscribing from events
To unsubscribe from events it's pretty much the same premise, minus the callback.
```gdscript
StreamerBot.unsubscribe({"twitch":["ChatMessage"]})
```

# Executing actions
There are **four** ways to execute actions.
```gdscript
StreamerBot.do_action({"id":"<id>"}
StreamerBot.do_action({"name":"<name>"}
StreamerBot.do_action_from_name("<name>")
StreamerBot.do_action_from_id("<id>")
```

To get an action's ID, just right-click it in Streamer.bot and click "Copy Action Id". Though doing it with its name I think is more convenient.

## Executing actions with arguments
To execute an action with arguments, you can use a dictionary:
```gdscript
StreamerBot.do_action_from_name("Test", {"key1":"value1","key2":"value2"})
```

## Finding available actions
Same premise as finding available events, using the `get_actions()` function.
```gdscript
print(await StreamerBot.get_actions()())
```
I recommend using a [JSON formatter](https://json.fans/) to read it all.

# Other functions
You can [learn more about the websocket requests here](https://docs.streamer.bot/api/servers/websocket/requests).
## `test_credits`
Fill credits system with test data for testing.
```gdscript
await StreamerBot.test_credits()
```
## `clear_credits`
Reset the current credits system data.
```gdscript
await StreamerBot.clear_credits()
```
## `get_info`
Fetch information about the connected Streamer.bot instance.
```gdscript
var info = await StreamerBot.get_info()
```
## `get_active_viewers`
Fetch a list of all active viewers for connected Twitch or YouTube accounts.
```gdscript
var active_viewers = await StreamerBot.get_active_viewers()
```
