import utils

host = "archpc"
format = "[%artist% - %title% \\[%album%\\]]|%file%"
symbols = {
        "[playing]": "play",
        "[paused]": "pause"
        }
error_message = "<fc=#ff0000><icon=phones.xbm/> Can't connect to mpd</fc>"
stopped_message = "<icon=phones.xbm/> Nothing playing at the moment"

def symbol(out):
    state = out.splitlines()[1].split(" ")[0]
    if state in symbols:
        return "<icon=%s.xbm/>" % symbols[state]
    else:
        return ""

def position(out):
    split = out.splitlines()[1].split(" ")

    found = 0
    for s in split:
        if not s == "":
            if found == 2:
                return s
            else:
                found += 1

    return ""

if __name__ == "__main__":
    out, success = utils.call_command(["mpc", "-h", host, "-f", format])
    if not success:
        print(error_message)
    elif len(out.splitlines()) == 1:
        print(stopped_message)
    else:
        formatted = out.splitlines()[0]
        print("%s %s (%s)" % (symbol(out), formatted, position(out)))
