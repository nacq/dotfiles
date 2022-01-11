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
├── setup                               # DEPRECATED
│   └── macos
│       ├── setup.sh
│       └── yin_with_colors.itermcolors
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
├── .xinitrc                            # root level hidden files will be symliked in the home dir
├── .Xmodmap
├── .Xresources
└── .zshrc
```
