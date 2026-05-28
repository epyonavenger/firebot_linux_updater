# Firebot Linux Updater
A dumb and bad shell script to update firebot on Linux.

Basically just took the idea from Discord's updater, and made it work for me.

## Prerequisites
* jq
* curl
* grep
* head
* tar

## How To Install
1. Download the `update_firebot.sh` somewhere.
2. Make sure it's executable.
3. Execute it.
4. Profit.

## How To Use Post-Install
The `firebot.desktop` file will automatically call the script ahead of running Firebot, and if there's an update, it'll download it, install it, and execute it.

## TODO
* Deal with errors by executing most-recent version instead of bailing when it can't do the cURL and such properly.
* Download and parse the json instead of doing extra cURLs.
* Log file?
* Proper paths for bins, or at least some kinda something to make sure it doesn't get distracted by other stuff.
