Dotfiles
========

After cloning this repo, run `install` to automatically set up the
development environment. Note that the install script is idempotent - running
it multiple times has no effect.

Dotfiles uses [Dotbot][dotbot] for installation.

To use tmux Powerline in PuTTY :
- Download the patched fonts. I chose DejaVuSansMono as my font since I like it most.
- Install this font in Windows to make it accessible for all programs.
- Open PuTTY and make changes to the settings:
    - Under appearance select the patched font
    - Select font quality Clear Type
    - Under Translation select character set UTF-8
- Apply settings and restart the PuTTY session

Configurations files
--------------------

* `tmux`
* `vim`

License
-------

Released under the MIT License. See [LICENSE.md][license] for details.

[dotbot]: https://github.com/anishathalye/dotbot
[license]: LICENSE.md
