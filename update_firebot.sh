#!/usr/bin/env sh

INSTALL_DIR="$HOME/.local/opt/firebot"

LATEST_RELEASE="$(curl --silent --location https://api.github.com/repos/crowbartools/Firebot/releases | jq --raw-output .[0].url )"
LINUX_TAR="$(curl --silent --location $LATEST_RELEASE | jq --raw-output .assets.[].name | grep '.tar.gz' )"
LINUX_TAR_URL="$(curl --silent --location $LATEST_RELEASE | jq --raw-output .assets.[].browser_download_url | grep '.tar.gz' )"

APP_DIR_NAME="$(echo $LINUX_TAR | head -c -8)"
APP_DIR="$INSTALL_DIR/$APP_DIR_NAME"
ICON_DIR="$HOME/.local/share/icons/hicolor"

# Debug Variables
#echo "$INSTALL_DIR"
#echo "$LATEST_RELEASE"
#echo "$LINUX_TAR"
#echo "$LINUX_TAR_URL"

# Make initial directories.
mkdir -p "$INSTALL_DIR"
mkdir -p "$ICON_DIR"

# Make sure this script is in the top-level directory for future executions.
cp "$0" "$INSTALL_DIR/"
chmod +x "$INSTALL_DIR/update_firebot.sh"

if [[ -f /usr/bin/notify-send ]]; then
  notify-send "Firebot Updater" "Checking for updates..."
else
  echo "Checking for Firebot updates..."
fi

if [[ ! -d $APP_DIR ]]; then
  # Enter top-level directory.
  cd "$INSTALL_DIR"

  # If the tar exists, but didn't get unarchived for some reason, do it now.
  if [[ -f $LINUX_TAR ]]; then
    tar -xzf "$LINUX_TAR" --one-top-level
  else
    # Fetch Linux .tar.gz release.
    curl --silent --location --remote-name "$LINUX_TAR_URL"

    # Unarchive the tar into the main folder.
    tar -xzf "$LINUX_TAR" --one-top-level

    # Grab icons and put them in the user icon directory.
    cd "$APP_DIR/resources/linux/firebotsetup-icon"
    for icon in *; do
      ICON_SIZE="$(echo $icon | cut -d '.' -f1)"
      mkdir -p "$ICON_DIR/$ICON_SIZE/apps/"
      cp $icon "$ICON_DIR/$ICON_SIZE/apps/firebot.png"
    done

    # Copy mimetype definitions.
    cp "$APP_DIR/resources/linux/firebotsetup-mimetype.xml" "$HOME/.local/share/mime/packages/"

    # Create .desktop file.
    cat << EOF > "$HOME/.local/share/applications/firebot.desktop"
[Desktop Entry]
Type=Application
Name=Firebot
Comment=A Powerful all-in-one bot for Twitch Streamers
Icon=firebot
Exec="$INSTALL_DIR/update_firebot.sh" %U
Categories=Network;Chat
StartupWMClass=firebotv5
MimeType=application/x-firebotsetup
EOF
  fi
fi

if [[ -f /usr/bin/notify-send ]]; then
  notify-send "Firebot Updater" "Firebot is up to date, launching!"
else
  echo "Firebot is already up to date, launching!"
fi


# Return to top-level directroy, just in case.
cd "$APP_DIR"

# Start Firebot.
exec "./Firebot v5" "$@"
