# cleanup-android

Removes Android bloatware.


## Requires

Android SDK platform tools (adb).

Download [Command line tools only](https://developer.android.com/studio#downloads), unpack, and run:

```
sdkmanager.bat --install "platform-tools" "extras;google;usb_drive"
```

Then setup the environment variable `ANDROID_SDK_ROOT`:

```
setx ANDROID_SDK_ROOT <path to the folder that contains 'platform-tools'>
```


## Use

Turn on [Developer Mode](https://developer.android.com/studio/debug/dev-options) on a device.

Connect a device to PC, and select `Transfer files` mode in a popup on a device.

Run `get-apps.ps1` to get all installed apps (will be in `app_list.txt`).

Adjust the list of apps to uninstall in `uninstall-apps.ps1` and run.
