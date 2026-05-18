------------------
---- MONITORS ----
------------------

hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "1", -- Based on your old config scale=1
})

---------------------
---- MY PROGRAMS ----
---------------------

local mainMod     = "SUPER"
local terminal    = "ghostty"
local fileManager = "dolphin"
local menu        = "rofi -show run"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function()
  hl.exec_cmd("waybar")
  hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
  hl.exec_cmd("hyprpaper")
  hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
  hl.exec_cmd("udiskie &")
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
  general = {
    gaps_in     = 5,
    gaps_out    = 12,
    border_size = 1,
    col         = {
      active_border   = { colors = { "rgba(cba6f7ee)", "rgba(203,166,247,1)" }, angle = 45 },
      inactive_border = "rgba(313244aa)",
    },
    layout      = "dwindle",
  },
  input = {
    kb_layout    = "us",
    follow_mouse = 1,
    touchpad     = {
      natural_scroll = false,
    },
  },
  dwindle = {
    preserve_split = true,
  },
  decoration = {
    rounding = 12,
    rounding_power = 2
  }
})

hl.window_rule({
  name = "no-rounding-fullscreen",
  match = { fullscreen = true },
  rounding = 0,
})

---------------------
---- KEYBINDINGS ----
---------------------

-- ── Core Binds ─────────────────────────────────────────
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(mainMod .. " + SHIFT + Space", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))

-- Special Exit/Shutdown Logic
local exitCmd = "command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(exitCmd))

-- ── Navigation (HJKL) ──────────────────────────────────
local directions = { H = "left", L = "right", K = "up", J = "down" }

for key, dir in pairs(directions) do
  -- Focus
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ direction = dir }))
  -- Move Window
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }))
end

-- ── Resizing ───────────────────────────────────────────
-- H: Resize Left (Subtract 41 from X)
hl.bind(mainMod .. " + ALT + H", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
-- L: Resize Right (Add 40 to X)
hl.bind(mainMod .. " + ALT + L", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
-- K: Resize Up (Subtract 40 from Y)
hl.bind(mainMod .. " + ALT + J", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + ALT + K", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })

-- ── Workspaces (1-5) ───────────────────────────────────
for i = 1, 5 do
  hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Mouse Scroll Workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- ── Mouse Binds ────────────────────────────────────────
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ── Media & Brightness ─────────────────────────────────
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

-- ── Screenshot ─────────────────────────────────────────
hl.bind("Print", hl.dsp.exec_cmd("grimblast copy area"))
hl.bind("SHIFT" .. " + Print", hl.dsp.exec_cmd("grimblast copy screen"))

-- ── Screenrecordig ─────────────────────────────────────────
-- Super + Alt + S: Full Screen + System Audio Only
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("~/.config/hypr/scripts/record_full_audio.sh"))
-- Super + Alt + M: Full Screen + Microphone Only
hl.bind(mainMod .. " + ALT + M", hl.dsp.exec_cmd("~/.config/hypr/scripts/record_full_mic_only.sh"))
-- Super + Alt + D: Full Screen + Dual Audio (System + Mic)
hl.bind(mainMod .. " + ALT + D", hl.dsp.exec_cmd("~/.config/hypr/scripts/record_full_dual_audio.sh"))
-- Super + Alt + X: Full Screen + Completely Silent
hl.bind(mainMod .. " + ALT + X", hl.dsp.exec_cmd("~/.config/hypr/scripts/record_full_silent.sh"))

-- dark mode
-- hl.dsp.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme "YOUR_DARK_GTK3_THEME"")
-- hl.dsp.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme prefer-dark")
