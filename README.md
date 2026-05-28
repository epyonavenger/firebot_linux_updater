# Firebot Linux Updater
A dumb and bad shell script to update firebot on Linux.

Basically just took the idea from Discord's updater, and made it work for me.

## WARNING
DO NOT JUST DOWNLOAD THINGS FROM THE INTERNET AND INSTALL THEM

Seriously.

PLEASE review the shell script yourself, try and understand what is going on, and make sure you like what it is up to.

Don't assume anything out there is safe, helpful, or functional.

Use your eyes, use your brains.

## Prerequisites
* jq
* curl
* grep
* head
* tar

## How To Install
1. REVIEW THE WARNING ABOVE.
2. Download the `update_firebot.sh` somewhere.
3. Make sure it's executable.
5. Execute it.
6. Profit.

## How To Use Post-Install
The `firebot.desktop` file will automatically call the script ahead of running Firebot, and if there's an update, it'll download it, install it, and execute it.

## TODO
* Deal with errors by executing most-recent version instead of bailing when it can't do the cURL and such properly.
* Download and parse the json instead of doing extra cURLs.
* Log file?
* Proper paths for bins, or at least some kinda something to make sure it doesn't get distracted by other stuff.
