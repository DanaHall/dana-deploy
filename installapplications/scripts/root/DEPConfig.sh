#!/bin/bash

## First Boot for Technolutionary DEP Setup

## Goals: Having configured Munki via Profile and installed tools via InstallApplications, activate Munki and launch the Managed Software Center Application to begin downloads.

## Secondary Goals: Inform the user what's happening.

echo "Command: MainText: Welcome to your new Dana machine! We've got a few more steps to get your machine ready for first use. Hang tight and watch the screen. Call us if you have trouble at 781-489-1969." >> /var/tmp/depnotify.log

echo "Command: WindowTitle: Welcome to Dana" >> /var/tmp/depnotify.log

chmod 644 /var/tmp/depnotify.log

open /Applications/DEPNotify.app

sleep 10

echo "Status: Starting First Operations" >> /var/tmp/depnotify.log

sleep 5

sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users ladmin -privs -all -restart -agent -menu

sleep 5

echo "Status: Loading Munki LaunchDaemons" >> /var/tmp/depnotify.log

/bin/launchctl load /Library/LaunchDaemons/com.googlecode.munki.managedsoftwareupdate-check.plist
/bin/launchctl load /Library/LaunchDaemons/com.googlecode.munki.managedsoftwareupdate-install.plist
/bin/launchctl load /Library/LaunchDaemons/com.googlecode.munki.managedsoftwareupdate-manualcheck.plist

sleep 5

sudo defaults write /Library/Preferences/ManagedInstalls SoftwareRepoURL "https://caesar.danahall.org/munki_repo"
sudo defaults write /Library/Preferences/ManagedInstalls InstallAppleSoftwareUpdates -bool True
sudo defaults write /Library/Preferences/ManagedInstalls SuppressUserNotification -bool True
sudo defaults write /Library/Preferences/ManagedInstalls AdditionalHttpHeaders -array "Authorization: Basic bmdpbng6ZzExbTEzTXlEQHRA"
sudo defaults write /Library/Preferences/ManagedInstalls ShowOptionalInstallsForHigherOSVersions -bool False

touch /Users/Shared/.com.googlecode.munki.checkandinstallatstartup

sleep 5

echo "Status: Launching Managed Software Center" >> /var/tmp/depnotify.log

/usr/bin/open -a /Applications/Managed\ Software\ Center.app

sleep 10

echo "Command: Notification: Software Download Beginning" >> /var/tmp/depnotify.log

exit 0