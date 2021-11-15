& $Env:ANDROID_SDK_ROOT\platform-tools\adb shell pm list packages -f `
| ForEach-Object { $_ -replace '^package:(([^=]+?)(?:(:?==([^=]+))?==([^=]+))?)=([^=\r\n]+)$',"`$6    `$1" } `
| Sort-Object `
| Out-File .\app_list.txt -Encoding utf8
