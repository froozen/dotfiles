#!/usr/bin/env python2

import json
from sys import argv

# This is pretty unsafe, so watch out!
template = None
data = None

with open(argv[1]) as f:
    template = f.read()

with open(argv[2]) as f:
    data = json.loads(f.read())

for key, val in data.iteritems():
    template = template.replace("%%%%%s%%%%" % key, val)

print template
