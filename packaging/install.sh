#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd -- "$SCRIPT_DIR/.." && pwd)"
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"

echo "Installing Awaria KDE Theme..."

# User-level KDE components
mkdir -p \
    "$DATA_DIR/plasma/desktoptheme" \
    "$DATA_DIR/plasma/look-and-feel" \
    "$DATA_DIR/color-schemes" \
    "$DATA_DIR/wallpapers"

# Plasma Style
rm -rf "$DATA_DIR/plasma/desktoptheme/Awaria"
cp -a "$PROJECT_ROOT/plasma-style/Awaria" "$DATA_DIR/plasma/desktoptheme/Awaria"

# Global Theme (includes the Awaria lock screen and splash QML)
rm -rf "$DATA_DIR/plasma/look-and-feel/com.awaria.desktop"
cp -a "$PROJECT_ROOT/global-theme" "$DATA_DIR/plasma/look-and-feel/com.awaria.desktop"

# Color Scheme
install -m 0644 \
    "$PROJECT_ROOT/color-scheme/Awaria.colors" \
    "$DATA_DIR/color-schemes/Awaria.colors"

# Standalone wallpaper packages
for pkg in "$PROJECT_ROOT"/plasma-style/Awaria/wallpapers/*; do
    [[ -d "$pkg" ]] || continue
    target="$DATA_DIR/wallpapers/$(basename "$pkg")"
    rm -rf "$target"
    cp -a "$pkg" "$target"
done

# Also install the three plain wallpaper images for easy manual selection.
rm -rf "$DATA_DIR/wallpapers/Awaria"
mkdir -p "$DATA_DIR/wallpapers/Awaria"
cp -a "$PROJECT_ROOT/wallpapers/." "$DATA_DIR/wallpapers/Awaria/"

# SDDM is system-wide, so this is the only privileged step.
echo "Installing SDDM theme system-wide (sudo may prompt for your password)..."
sudo rm -rf /usr/share/sddm/themes/awaria
sudo mkdir -p /usr/share/sddm/themes/awaria
sudo cp -a "$PROJECT_ROOT/sddm/." /usr/share/sddm/themes/awaria/

echo
echo "Awaria KDE Theme installed."
echo "Global Theme: com.awaria.desktop"
echo "Plasma Style: Awaria"
echo "Color Scheme: Awaria"
echo "SDDM Theme: awaria"
echo "Open System Settings to apply the Awaria Global Theme."
