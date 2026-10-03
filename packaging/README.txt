# Awaria KDE Theme

Unofficial KDE Plasma 6 theme inspired by the visual identity of Awaria.

## Included

- Plasma Style (`Awaria`)
- Awaria color scheme
- Plasma 6 Global Theme / Look-and-Feel package (`com.awaria.desktop`)
- Custom lock screen UI embedded in the Global Theme
- Video splash screen embedded in the Global Theme
- SDDM login theme
- Three Awaria wallpapers
- Awaria Plasma icon assets
- Installation script

## KDE defaults intentionally retained

- Qt application style: Breeze
- Window decoration: Breeze
- Fonts: user's existing configuration
- Sounds: not included

## Install

From the extracted project directory:

```bash
chmod +x packaging/install.sh
./packaging/install.sh
```

This installs all user-level Plasma components under `${XDG_DATA_HOME:-~/.local/share}`.

To also install the SDDM login theme system-wide:

```bash
./packaging/install.sh --sddm
```

The SDDM step uses `sudo` because SDDM themes normally live in `/usr/share/sddm/themes/`.
After installation, select `awaria` in your distro's SDDM settings if it is not selected automatically.

## Package layout

```text
Awaria_KDE_theme/
├── color-scheme/
├── global-theme/
│   ├── manifest.json
│   └── contents/
│       ├── defaults
│       ├── lockscreen/
│       └── splash/
├── lockscreen/              # source copy
├── packaging/
├── plasma-style/
│   └── Awaria/
├── sddm/
├── splash/                  # source copy
└── wallpapers/
```

## Notes

The Global Theme wires the Awaria color scheme and Plasma Style together. Plasma 6 requires a `manifest.json` for Look-and-Feel packages, and custom splash / lock screen QML lives under the Global Theme's `contents/` tree.

The raw `lockscreen/` and `splash/` directories are kept as editable source copies; the installable copies are under `global-theme/contents/`.

## Version

0.1.0
