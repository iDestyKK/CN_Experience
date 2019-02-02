# CN\_Experience (My dot/config files)

## 1. Synopsis
These are files that I use to configure how my applications work on Linux.
I got tired of bullshit where my files are inconsistent, so I decided to make
a single repo that stores everything, and I could simply pull from it in order
to get the latest version of my stuff. Easy, right?

## 2. Installation Instructions
Just run `./install.sh`. Easy.

This script won't delete any files. It will create a `.cn_experience` directory
in your home directory to store everything. It will also inject paths into your
`.zshrc`, `.tmux.conf`, and `.vimrc` files if they exist. If they don't, then
they are created.

## 3. Applications
Most of my stuff (excluding plugins) are completely original and made by hand.
Though most of them are heavily inspired by powerline. You will find files for
my vim theme, zsh theme, tmux theme, and more here.

**The List:**
* tmux
* vim
* zsh

### 3.1. tmux
My tmux config changes up how it works completely. For starters, the prefix key
is remapped to C-a (Ctrl+A). Other corrections allow it to share the same
control scheme that GNU Screen has. It is shown in the .tmux.conf file as:
```
# Command                          Key                   Action
# -------------------------------------------------------------------------
bind | split-window -h           # |                   = Split horizontally
bind - split-window -v           # -                   = Split vertically

bind -n M-S-Left previous-window # Alt + Shift + Left  = Previous Window
bind -n M-S-Right next-window    # Alt + Shift + Right = Next Window

bind r source-file ~/.tmux.conf  # r                   = Reload config file
```

You get my SINOBUZ theme for tmux as well. It changes colours based on the day
of the week. It's covered more in depth in the **Themes** section.

### 3.2. vim
The following repos added:
* Syntastic
* Nerdtree (Renamed to "PRINCESS")
* Vim-Airline
* Vim-Fugitive

The following hotkeys are added:
* F7 - Previous Tab/Buffer
* F8 - Next Tab/Buffer
* C-n (Ctrl+N) - NERDTreeToggle
* C-b (Ctrl+B) - TagbarToggle

Other features include:
* Tab/Buffer support! Press F7/F8 to navigate across files.
* 4 space tabs.
* Improved bottom-bar with colouring for whatever mode you are in.
* See errors in your code without having to compile it via Syntastic!

You can open multiple files in VIM at once via:
```
UNIX> vim file1 file2 ...
```
And then switch between them with F7/F8.

### 3.3. zsh
You get my SINOBUZ ZSH theme, a theme that changes based on the day of the
week. It's covered in the **Themes** section. You also get a few of my aliases.
Check them out!

## 4. Themes
### 4.1. SINOBUZ
One of my notable themes is SINOBUZ (based on Beatmania IIDX 24: SINOBUZ). The
colour of the theme changes depending on the day of the week.
* **Sunday (日)** - Purple (Sun)
* **Monday (月)** - Pink (Moon)
* **Tuesday (火)** - Red (Fire)
* **Wednesday (水)** - Blue (Water)
* **Thursday (木)** - Green (Wood)
* **Friday (金)** - Grey/Gold (Metal/Gold)
* **Saturday (土)** - Orangish Clay (Earth [not the planet]/Ground/Saturn [土星])

### 4.2. Unnamed Pink Theme (& Variants)
SINOBUZ was originally based off of a pink powerline-like theme I wrote. It has
variables in it that can be changed to change the colours of the prompt in its
entirety (hence how I got SINOBUZ working). The original colour scheme was a
bright pink colour. There also is a purple variant, as well as a blue variant.

## 5. VIM Syntax Files
### 5.1. CN\_Script
I am the creator of CN\_Script, a scripting language heavily based on C. Of
course, it actually *transpiles* into C via `cns` (I wrote that too), which
can be compiled into an actual executable.

Why do I say this? Because there exists a VIM syntax file for it, and it's
in `.vim/syntax/cn_script.vim`! It isn't perfect (yet), but I'll be improving
it as time passes on.
