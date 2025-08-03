# Tylex

A simple, fast, and powerful text expansion utility for the modern Linux desktop, using your favorite menu launcher (`rofi` or `dmenu`).

Tylex lets you create short abbreviations (e.g., `em`) that expand into longer phrases or snippets of text (e.g., `user@example.com`). It's written in pure shell script, making it lightweight and a perfect fit for any workflow, from minimal tiling window managers to full-featured desktop environments.

---
## Features

  * **Flexible Actions**: Press `Enter` to type text instantly, or press `Ctrl+Enter` to copy it to the clipboard.
  * **Fast & Lightweight**: Written in shell script with minimal dependencies.
  * **Launcher-Based**: Uses `rofi` or `dmenu`, so it integrates perfectly with your existing workflow.
  * **Usage-Aware**: Automatically sorts your expansions by how often you use them.
  * **Fuzzy Finding**: Full fuzzy search support when using `rofi`.
  * **XDG Compliant**: Follows standards for storing configuration and data files.
---
## Dependencies

You will need the following programs installed:
  * `bash`
  * `jq` (for parsing JSON)
  * `xclip` (for copy-to-clipboard functionality)

**And one of the following launchers:**
  * `rofi` (recommended)
  * `dmenu`

**And a display-server-specific tool for typing:**
  * For **X11** sessions: `xdotool`
  * For **Wayland** sessions: `wtype`

Tylex will automatically detect your session type and use the appropriate tool.
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

Tylex is most effective when bound to a keyboard shortcut. The process differs between graphical desktop environments and tiling window managers.

A safe and memorable shortcut is `Super + ;` (the Super key is the Windows or Command key).

### Desktop Environments (GNOME, KDE, XFCE)

Most desktop environments provide a graphical settings panel to create custom keyboard shortcuts that run a command.

1.  Open your system's **Settings** application.

2.  Navigate to the **Keyboard** or **Shortcuts** section.

3.  Look for an option to add a **Custom Shortcut**.

4.  Create two new shortcuts with the following details:

      * **Shortcut 1: Expand Text**
          * **Name:** `Tylex Expand`
          * **Command:** `tylex-expand`
          * **Shortcut:** `Super + ;`
      * **Shortcut 2: Add Expansion**
          * **Name:** `Tylex Add`
          * **Command:** `tylex-add`
          * **Shortcut:** `Super + Shift + ;`

### Tiling Window Managers

For tiling window managers, you'll need to edit your configuration file directly.

#### i3wm (`~/.config/i3/config`)

```
# Tylex: Expand a snippet
bindsym $mod+semicolon exec tylex-expand

# Tylex: Add a new snippet
bindsym $mod+Shift+semicolon exec tylex-add
```

#### Sway (`~/.config/sway/config`)

The syntax is identical to i3.

```
# Tylex: Expand a snippet
bindsmy $mod+semicolon exec tylex-expand

# Tylex: Add a new snippet
bindsym $mod+Shift+semicolon exec tylex-add
```

#### bspwm (`~/.config/sxhkd/sxhkdrc`)

```
# Tylex: Expand a snippet
super + semicolon
    tylex-expand

# Tylex: Add a new snippet
super + shift + semicolon
    tylex-add
```

#### AwesomeWM (`~/.config/awesome/rc.lua`)

```lua
awful.keyboard.append_global_keybindings({
  -- Tylex: Expand a snippet
  awful.key({ modkey }, ";", function () awful.spawn.with_shell("tylex-expand") end,
            {description = "Expand Tylex snippet", group = "launcher"}),

  -- Tylex: Add a new snippet
  awful.key({ modkey, "Shift" }, ";", function () awful.spawn.with_shell("tylex-add") end,
            {description = "Add Tylex snippet", group = "launcher"})
})
```
---
## Wayland Compatibility

This script relies on `xdotool` and will not work on Wayland out of the box. To adapt it, install a Wayland-native tool like `wtype` and replace the `xdotool` loop in `/usr/bin/tylex-expand` with `echo "$value" | wtype -`.
