# dot_files

![xkcd comic about computer only being usable by the owner](https://imgs.xkcd.com/comics/borrow_your_laptop.png)
Image Source: [XKCD #1806](https://xkcd.com/1806/) by Randall Munroe.

These dotfiles have been mutating over the years as I've used Ubuntu as a primary driver at work (heavily customized with)
i3wm and cool mechanical keyboards.
I've also been using MacOS personally and professionally and SSHing into servers more so the tools tend to reflect that.

`tmux` and `vim` are my bread and butter for remote connections, but `hx` (Helix Editor) is intriguing.
I've been trying to use tmux and vim with as near standard as possible so I _can_ use it at work and home more easily.

That said I can see porting some changes to all systems.


Anyways this is a personal repo, but its out here for anyone to look at, so have fun, hope you learn something from this,
and happy hacky!

## Programs assumed to be installed by dotfiles

- vim
- helix editor
- docker
- zsh (with ohmyzsh)
- kitty (for kssh, might remove)
- git
- ssh
- fzf
- jq

### tmux

Tmux config assumes that both
- [TPM (tmux plugin manager)](https://github.com/tmux-plugins/tpm) and
- [Dracula Theme](https://draculatheme.com/tmux)
are both installed

Stuff I like that isn't _required_
- lazygit

## Programs I always use and may forget the names of

### Commandline

- `vis` - Visualizer https://github.com/dpayne/cli-visualizer
- `cava` - Visualizer
- `bat` - a better version of cat https://github.com/sharkdp/bat
- `fzf` - fuzzy searching on the CLI https://github.com/junegunn/fzf

### MacOS

- [Rectangle app](https://rectangleapp.com/) for keyboard-based window management
- Skitch for screenshots with quick arrow annotations and blurring
- OrbStack for way less power hungry docker management
- [NetNewsWire](https://netnewswire.com/) for RSS reader

## i3 and other Linux customization?

Want to go back to i3 or get some linux customization info? (Finally switching to a linux desktop for gaming?)
Then go to commit `456b132dacdaf5dad1695aea823a81b82fd6c5a4` which is right before I removed the i3 folder.

## Setup Notes

- Remember to [setup 256 colour support and italic support for tmux and terminal](https://weibeld.net/terminals-and-shells/italics.html) otherwise the helix Dracula theme looks _awful_
