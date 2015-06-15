#!/usr/bin/python2
import weechat
import subprocess

weechat.register("weechat-notify", "fro_ozen", "1.0", "None", "libnotify notifications for weechat", "", "")

options = {
        "blacklist": ("", "comma-separated list of channels to be ignored"),
        "enable_sound": ("off", "enable playing sound via sox"),
        }

for option, default_value in options.items():
    if not weechat.config_is_set_plugin(option):
        weechat.config_set_plugin(option, default_value[0])
        weechat.config_set_desc_plugin(option, default_value[1])

enable_sound = weechat.config_string_to_boolean(weechat.config_get_plugin("enable_sound"))
blacklist = weechat.config_string(weechat.config_get_plugin("blacklist")).split(",")

def on_privmsg(data, signal, signal_data):
    msg_info = weechat.info_get_hashtable("irc_message_parse", { "message": signal_data})

    if not msg_info["channel"] in blacklist:
        content = msg_info["arguments"].split(":");
        content = ":".join(content[1:len(content)])

        subprocess.call(["notify-send", "%s on %s" % (msg_info["nick"], msg_info["channel"]), content])

        if enable_sound:
            if msg_info["channel"].startswith("#"):
                play_process = subprocess.call(["play", "-qn", "-V0", "synth", "0.09", "tri", "E3:B3", "&"])
            else:
                play_process = subprocess.call(["play", "-qn" "-V0", "synth", "0.09", "tri", "C3:F3", "&"])

    return weechat.WEECHAT_RC_OK

def on_config(data, option, value):
    global blacklist, enable_sound

    option = option[len("plugins.var.python.weechat-notify."):]

    if option == "blacklist":
        blacklist = weechat.config_get_plugin("blacklist").split(",")
    elif option == "enable_sound":
        enable_sound = weechat.config_string_to_boolean(weechat.config_get_plugin("enable_sound"))

    return weechat.WEECHAT_RC_OK

weechat.hook_signal("*,irc_in2_privmsg", "on_privmsg", "")
weechat.hook_config("plugins.var.python.weechat-notify.*", "on_config", "")
