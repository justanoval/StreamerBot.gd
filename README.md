An addon for Godot 4 to interact with Streamer.bot.

# About
This addon was made by [justan oval](https://justanoval.com/): I make interactive streams over on [my Twitch](https://www.twitch.tv/justanoval), and everything is made in **Godot Engine**!

I've made many utilities along my development journey to make this easier for myself. I figured I can make these tools available for others that aspire to make interactive streams as well.

# Installation
1. Download the latest release in [the releases tab](https://github.com/justanoval/StreamerBot.gd/releases).
2. Put the unzipped files into `res://addons/streamer-bot/`

# Getting started
First, make sure your Websocket Server is on. You can enable this in the `Servers/Clients` tab under `Websocket Server` (not `Websocket Servers`). It should look like this:
![image](https://github.com/user-attachments/assets/61ba3be5-88f3-4f84-9cec-1b40b59c2564)

You can change the address and port if you'd ilke to.

Then, create a script that extends `StreamerBot`, and either attach it to a `Node` or [make it autoload](https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html).
```gdscript
extends StreamerBot

func _ready():
  var err = self.connect_to_websocket()
  if err != OK:
    push_error("Websocket could not connect. Error: " % err)
  else:
    print("Connected!")
  
  await connected
```

If you changed your address and port in the Streamer.bot settings, you can reflect that like so:
```gdscript
self.connect_to_websocket(8081)
self.connect_to_websocket(8081, "127.0.0.1")
```

You can also disable `auto_reconnect` if you don't want to reconnect to the websocket server every time it closes (I've found it may often close at random):
```gdscript
self.connect_to_websocket(8081, "127.0.0.1", false)
```

# Subscribing to events
To subscribe to an event, you can use the following function:
```gdscript
subscribe({"<event category>":["<event name>", "<event name>"]}, self.callback)
```
For example:
```gdscript
subscribe({"twitch":["ChatMessage"]}, self._on_chat_message)
```
Then, `on_chat_message` would be:
```gdscript
func _on_chat_message(response: Dictionary):
  var message_object = response.data.message
	print("%s: %s" % [ message_object.channel, message_object.message ])
```
This would print the message like:
> justanoval: hello!

Each action comes with a response, so if you'd like to check if it actually subscribes, you can do that like so:
```gdscript
var response = await subscribe({"twitch":["ChatMessage"]}, self._on_chat_message)
if response.status == "ok":
  print("Subscribed")
else response.status == "error":
  push_error("Failed to subscribe")
```

## Finding available events
The best way to find available events is by using the `get_events()` function
```gdscript
print(await self.get_events())
```
This will give a rather _massive_ list. I'd recommend using a [JSON formatter](https://json.fans/) to read them all.

# Unsubscribing from events
To unsubscribe from events it's pretty much the same premise, minus the callback.
```gdscript
unsubscribe({"twitch":["ChatMessage"]})
```

# Executing actions
There are **four** ways to execute actions.
```gdscript
do_action({"id":"<id>"}
do_action({"name":"<name>"}
do_action_from_name("<name>")
do_action_from_id("<id>")
```

To get an action's ID, just right-click it in Streamer.bot and click "Copy Action Id". Though doing it with its name I think is more convenient.

## Executing actions with arguments
To execute an action with arguments, you can use a dictionary:
```gdscript
do_action_from_name("Test", {"key1":"value1","key2":"value2"})
```

## Finding available actions
Same premise as finding available events, using the `get_actions()` function.
```gdscript
print(await self.get_events())
```
I recommend using a [JSON formatter](https://json.fans/) to read it all.

# Other functions
You can [learn more about the websocket requests here](https://docs.streamer.bot/api/servers/websocket/requests).
## `test_credits`
Fill credits system with test data for testing.
```gdscript
await test_credits()
```
## `clear_credits`
Reset the current credits system data.
```gdscript
await clear_credits()
```
## `get_info`
Fetch information about the connected Streamer.bot instance.
```gdscript
var info = await get_info()
```
## `get_active_viewers`
Fetch a list of all active viewers for connected Twitch or YouTube accounts.
```gdscript
var active_viewers = await get_active_viewers()
```
