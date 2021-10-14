& $Env:ANDROID_SDK_ROOT\platform-tools\adb shell pm list packages -f | %{ $_ -replace '^package:(([^=]+?)(?:(:?==([^=]+))?==([^=]+))?)=([^=\r\n]+)$',"`$6    `$1" } | sort | Out-File .\app_list.txt
