dotfiles
========

This is where I keep all of my important and nicely groomed configuration
files. I use [stow][gnu_stow] to manage them.

I've split my dotfiles into the following categories:
- `general`: Files that I'll need on a server as well as on a machine running
  a Xorg server
- `X`: Files used to configure graphical things, such as a WM
- `res`: Technically no dotfiles at all. These are binary files needed for the
  `X` configuration, such as icons or fonts
- `slim-themes`: Themes for the SLiM login manager. They go into `/usr/share/slim/themes`.

---------
![A screenshot of my current setup](http://i.imgur.com/5wbRBoK.jpg)

[gnu_stow]: http://www.gnu.org/software/stow/
