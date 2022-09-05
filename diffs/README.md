Generate diffs with `git diff > toolname.diff` and apply them with `git apply path/to/patch.diff`.

Then I apply most of them with `rm config.h && sudo make clean install`.

Note: if there are missing libraries when trying to include them in any of these
programs, use for example `apt-file search mpd/client.h` to get the package to install.

https://suckless.org/hacking/
