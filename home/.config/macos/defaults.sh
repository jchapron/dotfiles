#!/usr/bin/env bash
# macOS preferences — minimal, keyboard-first, no animations, maximum screen space.
# Re-runnable. User-domain settings only; nothing here needs sudo.
# Apply:  bash ~/.config/macos/defaults.sh
set -euo pipefail

osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

# ---------------------------------------------------------------------------
# Appearance: always dark, graphite accent, no transparency
# ---------------------------------------------------------------------------
defaults write NSGlobalDomain AppleInterfaceStyle -string "Dark"
defaults delete NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically 2>/dev/null || true
defaults write NSGlobalDomain AppleAccentColor -int -1            # graphite
defaults write NSGlobalDomain AppleHighlightColor -string "0.847059 0.847059 0.862745 Graphite"
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2   # sidebar icon size: medium
defaults write com.apple.universalaccess reduceTransparency -bool true 2>/dev/null || true

# ---------------------------------------------------------------------------
# Animations off (or as close as macOS allows)
# ---------------------------------------------------------------------------
defaults write com.apple.universalaccess reduceMotion -bool true 2>/dev/null || true
defaults write com.apple.Accessibility ReduceMotionEnabled -int 1
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001
defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false
defaults write NSGlobalDomain NSToolbarFullScreenAnimationDuration -float 0
defaults write NSGlobalDomain NSBrowserColumnAnimationSpeedMultiplier -float 0
defaults write NSGlobalDomain NSDocumentRevisionsWindowTransformAnimation -bool false
defaults write NSGlobalDomain QLPanelAnimationDuration -float 0
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.dock launchanim -bool false
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock springboard-show-duration -float 0
defaults write com.apple.dock springboard-hide-duration -float 0
defaults write com.apple.dock springboard-page-duration -float 0
defaults write com.apple.Mail DisableSendAnimations -bool true
defaults write com.apple.Mail DisableReplyAnimations -bool true

# ---------------------------------------------------------------------------
# Screen space: hidden Dock and menu bar, no Stage Manager, no hot corners
# ---------------------------------------------------------------------------
defaults write NSGlobalDomain _HIHideMenuBar -bool true
defaults write NSGlobalDomain AppleMenuBarVisibleInFullscreen -bool false
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -float 0
defaults write com.apple.dock tilesize -int 36
defaults write com.apple.dock largesize -int 36
defaults write com.apple.dock magnification -bool false
defaults write com.apple.dock show-recents -bool false
defaults write com.apple.dock minimize-to-application -bool true
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock show-process-indicators -bool true
defaults write com.apple.dock orientation -string "bottom"
defaults write com.apple.dock mru-spaces -bool false            # keep Spaces in fixed order (AeroSpace)
defaults write com.apple.dock expose-group-apps -bool true       # AeroSpace recommendation
defaults write com.apple.WindowManager GloballyEnabled -bool false   # Stage Manager off
defaults write com.apple.WindowManager EnableStandardClickToShowDesktop -bool false
defaults write com.apple.WindowManager EnableTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTopTilingByEdgeDrag -bool false
defaults write com.apple.WindowManager EnableTiledWindowMargins -bool false
for corner in tl tr bl br; do
  defaults write com.apple.dock "wvous-${corner}-corner" -int 0
  defaults write com.apple.dock "wvous-${corner}-modifier" -int 0
done
# Displays have separate Spaces (AeroSpace works best with this on)
defaults write com.apple.spaces spans-displays -bool false

# ---------------------------------------------------------------------------
# Keyboard: fast repeat, hold-to-repeat (vim), full keyboard access, no autocorrect
# ---------------------------------------------------------------------------
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2           # tab through all controls
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticInlinePredictionEnabled -bool false
defaults write NSGlobalDomain WebAutomaticSpellingCorrectionEnabled -bool false
defaults write com.apple.HIToolbox AppleFnUsageType -int 0         # fn key does nothing (no emoji/dictation)

# Spotlight shortcut off: ⌘Space belongs to Raycast
python3 - <<'PY'
import plistlib, os
p = os.path.expanduser('~/Library/Preferences/com.apple.symbolichotkeys.plist')
d = plistlib.load(open(p, 'rb')); hk = d.setdefault('AppleSymbolicHotKeys', {})
for k in ('64', '65'):
    hk.setdefault(k, {'value': {'parameters': [65535, 49, 1048576], 'type': 'standard'}})['enabled'] = False
plistlib.dump(d, open(p, 'wb'))
PY
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u >/dev/null 2>&1 || true

# ---------------------------------------------------------------------------
# Trackpad & mouse
# ---------------------------------------------------------------------------
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool false

# ---------------------------------------------------------------------------
# Finder: dense, informative, no clutter
# ---------------------------------------------------------------------------
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"   # search current folder
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"   # list view
defaults write com.apple.finder NewWindowTarget -string "PfHm"        # new windows open at ~
defaults write com.apple.finder QuitMenuItem -bool true               # ⌘Q quits Finder
defaults write com.apple.finder WarnOnEmptyTrash -bool false
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool false
defaults write com.apple.finder CreateDesktop -bool false             # no icons on the desktop
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
chflags nohidden ~/Library 2>/dev/null || true

# ---------------------------------------------------------------------------
# Screenshots
# ---------------------------------------------------------------------------
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location -string "$HOME/Screenshots"
defaults write com.apple.screencapture type -string "png"
defaults write com.apple.screencapture disable-shadow -bool true
defaults write com.apple.screencapture show-thumbnail -bool false

# ---------------------------------------------------------------------------
# Menu bar: only Wi-Fi, Bluetooth, Sound, battery, clock.
# Third-party icons (Jamf, AeroSpace kept; OneDrive, Raycast, Adobe… hidden) are
# managed by Hidden Bar — ⌘-drag them left of its divider once.
# ---------------------------------------------------------------------------
show() { defaults write com.apple.controlcenter "NSStatusItem Visible $1" -bool true;  defaults -currentHost write com.apple.controlcenter "$1" -int 18; }
hide() { defaults write com.apple.controlcenter "NSStatusItem Visible $1" -bool false; defaults -currentHost write com.apple.controlcenter "$1" -int 24; }
for item in WiFi Bluetooth Battery Sound; do show "$item"; done
for item in NowPlaying Display FocusModes ScreenMirroring AirDrop KeyboardBrightness Hearing UserSwitcher AccessibilityShortcuts VPN MusicRecognition StageManager; do hide "$item"; done
defaults write com.apple.controlcenter "NSStatusItem Visible Siri" -bool false
defaults write com.apple.controlcenter "NSStatusItem Visible Spotlight" -bool false
defaults write com.apple.Siri StatusMenuVisible -bool false
defaults write com.apple.Spotlight MenuItemHidden -int 1                # Spotlight magnifier (macOS 13+)
defaults write com.apple.TextInputMenu visible -bool false              # keyboard input-source menu
defaults write com.apple.TextInputMenuAgent "NSStatusItem Visible Item-0" -bool false
defaults write com.apple.controlcenter BatteryShowPercentage -bool true
defaults write com.apple.menuextra.clock ShowSeconds -bool false
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
defaults write com.apple.menuextra.clock ShowDate -int 2                 # never show the date
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
defaults write NSGlobalDomain NSStatusItemSpacing -int 8                 # tighter icon spacing
defaults write NSGlobalDomain NSStatusItemSelectionPadding -int 6
# Third-party status items: the same flag a ⌘-drag removal writes
defaults write com.anthropic.claudefordesktop "NSStatusItem Visible Item-0" -bool false   # Claude
defaults write com.adobe.acc.AdobeCreativeCloud "NSStatusItem Visible Item-0" -bool false  # Adobe CC
# Adobe Creative Cloud: don't launch at login (its only reason to be in the menu bar)
launchctl disable "gui/$(id -u)/com.adobe.AdobeCreativeCloud" 2>/dev/null || true
launchctl bootout "gui/$(id -u)/com.adobe.AdobeCreativeCloud" 2>/dev/null || true
# Karabiner: no menu bar icon
if [[ -f ~/.config/karabiner/karabiner.json ]]; then
  python3 - <<'PY'
import json, os
p = os.path.expanduser('~/.config/karabiner/karabiner.json')
d = json.load(open(p)); d.setdefault('global', {})['show_in_menu_bar'] = False
json.dump(d, open(p, 'w'), indent=4)
PY
fi

# ---------------------------------------------------------------------------
# Sounds & misc
# ---------------------------------------------------------------------------
defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -int 0
defaults write NSGlobalDomain com.apple.sound.beep.flash -int 0
defaults write com.apple.LaunchServices LSQuarantine -bool false       # no "downloaded from the internet" dialog
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.ActivityMonitor ShowCategory -int 0
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
defaults write com.apple.CrashReporter DialogType -string "none"
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# ---------------------------------------------------------------------------
# Dock contents: only the apps in daily use, in order
# ---------------------------------------------------------------------------
if command -v dockutil >/dev/null; then
  dockutil --no-restart --remove all >/dev/null
  for app in \
    "/Applications/Ghostty.app" \
    "/Applications/Cursor.app" \
    "/Applications/Google Chrome.app" \
    "/Applications/Claude.app" \
    "/Applications/ChatGPT.app" \
    "/Applications/Slack.app" \
    "/Applications/Microsoft Teams.app" \
    "/Applications/Microsoft Outlook.app" \
    "/Applications/Microsoft Excel.app" \
    "/Applications/Microsoft PowerPoint.app" \
    "/Applications/Spotify.app" \
    "/Applications/WhatsApp.app"; do
    [[ -d "$app" ]] && dockutil --no-restart --add "$app" >/dev/null
  done
fi

# ---------------------------------------------------------------------------
# Default browser: Chrome (macOS asks for confirmation the first time)
# ---------------------------------------------------------------------------
command -v defaultbrowser >/dev/null && defaultbrowser chrome >/dev/null 2>&1 || true

# ---------------------------------------------------------------------------
# Wallpaper: flat Catppuccin Mocha base (#1e1e2e)
# ---------------------------------------------------------------------------
WALL="$HOME/.config/macos/wallpaper-mocha.png"
if [[ ! -f "$WALL" ]]; then
  python3 - "$WALL" <<'PY'
import struct, zlib, sys
w, h, rgb = 64, 64, (0x1e, 0x1e, 0x2e)
raw = b''.join(b'\x00' + bytes(rgb) * w for _ in range(h))
def chunk(t, d): return struct.pack('>I', len(d)) + t + d + struct.pack('>I', zlib.crc32(t + d) & 0xffffffff)
png = b'\x89PNG\r\n\x1a\n' + chunk(b'IHDR', struct.pack('>IIBBBBB', w, h, 8, 2, 0, 0, 0)) + chunk(b'IDAT', zlib.compress(raw, 9)) + chunk(b'IEND', b'')
open(sys.argv[1], 'wb').write(png)
PY
fi
osascript -e "tell application \"System Events\" to set picture of every desktop to POSIX file \"$WALL\"" 2>/dev/null \
  || echo "note: wallpaper not applied (Automation permission for System Events was denied)"

# ---------------------------------------------------------------------------
# Apply
# ---------------------------------------------------------------------------
for app in Dock Finder SystemUIServer ControlCenter cfprefsd; do
  killall "$app" >/dev/null 2>&1 || true
done
echo "macOS defaults applied. Some keyboard/trackpad settings need a logout to take effect."
