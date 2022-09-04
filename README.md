my shitty debian based dotfiles

```terminal
├── diffs                               # diffs to apply to (mainly suckless) programs
│   ├── dwm.diff
├── etc                                 # stuff in here will keep its dir structure and they will be symliked
│   ├── bluetooth
│   │   └── main.conf
├── log                                 # ignored by git, but to hold relevant logs
│   └── init
├── scripts                             # just bash scripts
│   ├── install.sh
│   └── monitors.sh
├── usr                                 # same as the above /etc dir
│   └── share
│       └── applications
│           └── brave-browser.desktop
├── vim                                 # don't like anymore these files, I'd prefer just one big .vimrc
│   └── bindings.vim
├── README.md
├── aliases                             # aliases that I find useful
├── exports                             # to set env variables
├── functions                           # functions that I usually use. These will be sourced and be globally available
├── .config                             # root level hidden files will be symliked in the home dir
│   └── share
│       └── nvim
│           └── init.vim
├── .xinitrc
├── .Xmodmap
├── .Xresources
└── .zshrc
```

tmux (leader ctrl-b)
```
| shortcut              | action                        |
|-----------------------|-------------------------------|
|leader - ctrl-"        | horizontal split              |
|leader - ctrl-%        | vertical split                |
|leader - ctrl-<number> | move to the window <number>   |
|leader - ctrl-=        | list clipboard                |
|leader - ctrl-T        | move window to the 0 position |
|leader - ctrl-[        | visual mode                   |
|leader - ctrl-]        | paste clipboard               |
|leader - ctrl-c        | create window                 |
|leader - ctrl-h        | move to the split on the left |
|leader - ctrl-j        | move to the split below       |
|leader - ctrl-k        | move to the split above       |
|leader - ctrl-l        | move to the split on the right|
|leader - ctrl-n        | move to the next window       |
|leader - ctrl-p        | move to the previous window   |
|leader - ctrl-r        | restore session               |
|leader - ctrl-s        | save session                  |
|leader - ctrl-t        | show time                     |
|leader - ctrl-x        | kill current split            |
```

dwm
```
| shortcut              | action                                         |
|-----------------------|------------------------------------------------|
|super-,                | focus previous monitor                         |
|super-shift-,          | move current window to previous monitor        |
|super-.                | focus next monitor                             |
|super-shift-.          | move current window to next monitor            |
|super-shift-<number>   | move current window to the <number> desktop    |
|super-<number>         | move to the desktop <number>                   |
|super-b                | toggle dwm bar                                 |
|super-c                | close current window                           |
|super-d                | window from horizontal to vertical split       |
|super-h                | increase window size to the left               |
|super-i                | window from vertical to horizontal split       |
|super-j                | focus next window                              |
|super-k                | focus previous window                          |
|super-l                | increase window size to the right              |
|super-space            | open dmenu                                     |
|super-shift-a          | volume down                                    |
|super-shift-d          | mute                                           |
|super-shift-enter      | open terminal                                  |
|super-shift-q          | quit dwm                                       |
|super-shift-s          | volume up                                      |
```
