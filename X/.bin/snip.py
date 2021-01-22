#!/bin/env python3

from sys import argv, exit

def main():
    if "--help" in argv:
        print("Usage: snip <infile> <outfile> <pagerange> ... <pagerange>")
        print("       Valid pageranges: d or d-d")
        exit(0)

    try:
        infile = argv[1]
        outfile = argv[2]
        ranges = argv[3:]
    except:
        print("Your arguments don't seem to be right :/")
        exit(1)

    for r, i in ranges:
        print("%i: %s" % (i, r))

if __name__ == "__main__":
    main()
