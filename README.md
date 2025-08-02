# Tylex

A simple, fast, and powerful text expansion utility for GNU Linux Tiling Window Managers that uses your favorite menu launcher (`rofi` or `dmenu`).

Tylex lets you create short abbreviations (e.g., `em`) that expand into longer phrases or snippets of text (e.g., `user@example.com`). It's written in pure shell script, making it lightweight and a perfect fit for tiling window manager workflows.

*![Tylex Screenshot](screenshots/tylex.jpg)*

## Features

-   **Fast & Lightweight**: Written in shell script with minimal dependencies.
-   **Launcher-Based**: Uses `rofi` or `dmenu`, so it integrates perfectly with your existing workflow.
-   **Usage-Aware**: Automatically sorts your expansions by how often you use them.
-   **Fuzzy Finding**: Full fuzzy search support when using `rofi`.
-   **XDG Compliant**: Follows standards for storing configuration and data files.

## Dependencies

You will need the following programs installed:
-   `bash`
-   `jq` (for parsing JSON)
-   `xdotool` (for simulating keyboard input on X11)
-   And one of the following launchers:
    -   `rofi` (recommended)
    -   `dmenu`

---
## Installation

Tylex will run with sensible defaults out of the box. If you want to customize its behavior, you will need to create a configuration file. The installation method determines how you do this.

### Method 1: Via a Package Manager (e.g., AUR)

This is the recommended method for most users.

1.  **Install the package**:
```sh
yay -S tylex-git
```
2.  **(Optional) Create a custom configuration**:
    The package manager will place a template config file in the system's documentation directory. To use it, copy it to your local config directory:
```sh
# Create the directory first
mkdir -p ~/.config/tylex

# Copy the template
cp /usr/share/doc/tylex/config.sh ~/.config/tylex/config.sh
```
You can now edit `~/.config/tylex/config.sh` to customize Tylex.

### Method 2: Manual Installation from Source

Use this method if a package is not available for your distribution.

1.  **Install the Scripts (with `sudo`)**:
    First, clone the repository and run the `install` command with `sudo` to copy the executable scripts and documentation to system-wide locations.
```sh
git clone https://github.com/raoeus/tylex.git
cd tylex
sudo make install
```

2.  **Create Your User Configuration (without `sudo`)**:
    Next, run the `config` command **as your regular user** (no `sudo`). This is a convenience command that copies the configuration template into your home directory for you.
```sh
make config
```

---
## Post-Installation: Setting a Hotkey

Tylex is most effective when bound to a keyboard shortcut. Add the following to your window manager's configuration file.

#### i3 Window Manager (`~/.config/i3/config`)
```
# Launch text expander (Super + z)
bindsym $mod+z exec tylex-expand

# Add a new expansion (Super + Shift + z)
bindsym $mod+Shift+z exec tylex-add
```

#### bspwm (`~/.config/sxhkd/sxhkdrc`)

```
# Launch text expander (Super + ;)
super + semicolon
    tylex-expand

# Add a new expansion (Super + Shift + ;)
super + shift + semicolon
    tylex-add
```

---

## Wayland Compatibility

This script relies on `xdotool` and will not work on Wayland out of the box. To adapt it, install a Wayland-native tool like `wtype` and replace the `xdotool` loop in `/usr/bin/tylex-expand` with `echo "$value" | wtype -`.
