﻿$adb = "$Env:ANDROID_SDK_ROOT\platform-tools\adb"

function uninstall($package)
{
    Write-Host Uninstallng $package
    try {
        & $adb shell pm path $package | %{ Write-Host "  $_"}
        if ($LastExitCode -ne 0) { Write-Host "  not installed" ; return }
        Write-Host "  am force-stop $package"
        & $adb shell am force-stop $package | %{ Write-Host "    $_"}
        Write-Host "  pm uninstall --user 0 $package"
        & $adb shell pm uninstall --user 0 $package | %{ Write-Host "    $_"}
        if ($LastExitCode -eq 0) { return }
        Write-Host "  pm disable-user --user 0 $package"
        & $adb shell pm disable-user --user 0 $package | %{ Write-Host "    $_"}
    }
    catch {
        Write-Host "  $($Error[0].ToString())" -ForegroundColor Red
    }
}

@'

#  Facebook
com.facebook.system
com.facebook.appmanager
com.facebook.services
com.facebook.katana

#  Email
com.android.email                           # Встроенный почтовый клиент, возможно потребуется удаление через настройки
com.android.email.partnerprovider
com.google.android.gm                       # GMail
com.oppo.gmail.overlay                      # А также оверлей GMail
ru.mail.mailapp                             # Почтовый клиент от MailRU

#  Google
com.google.android.keep                     # GKeep
com.google.android.feedback                 # Обратная связь
com.google.android.youtube                  # YouTube
com.google.android.apps.youtube.music       # YouTube музыка
com.google.android.apps.books               # Книги
com.google.android.apps.magazines           # Новости
com.google.android.apps.podcasts            # Подкасты
com.google.android.videos                   # Фильмы
com.google.android.apps.tachyon             # Duo
com.google.android.talk                     # Hangouts
#com.google.android.play.games              # Игры
#com.google.android.projection.gearhead     # Приложение Android Auto, для связи телефона с магнитолой в машине, можно скачать отдельно в маркете
#com.google.android.apps.wellbeing          # Цифровое благополучие, пункт в меню, ведет статистику работы пользователя, при желании ограничивает время работы в приложениях

#  Yandex
ru.yandex.searchplugin
com.yandex.browser

#  Oppo/Realme
com.coloros.assistantscreen                 # Умный помошник Oppo
com.coloros.backuprestore                   # Клонирование телефона от Oppo
com.coloros.floatassistant                  # Плавающая умная кнопка
com.coloros.phonenoareainquire              # Определение местоположения звонка
com.ted.number                              # Определение неизвестных номеров
com.coloros.video                           # Встроенный проигрыватель видео
com.coloros.videoeditor                     # Видео-редактор
com.heytap.habit.analysis                   # Аналитика heytap
com.heytap.mcs                              # Сообщения от heytap
com.heytap.music                            # Встроенный проигрыватель музыки
com.heytap.usercenter                       # Пункт в меню для регистрации на сайте Realme, предлагает бонусы за регистрацию, на самом деле обычный трекер, собирающий информацию о предпочтениях владельца телефона
com.heytap.usercenter.overlay               # Оверлей
#com.heytap.openid                          # Идентификатор устройства
#com.heytap.colorfulengine                  # Их фреймворк
com.nearme.browser                          # Браузер от Oppo
com.oppo.market                             # Магазин приложений от Oppo
com.oppo.operationManual                    # Руководство пользователя
com.oppo.partnerbrowsercustomizations       # Встраивание главной строницы OPPO в интернет-браузеры
com.oppo.quicksearchbox                     # Быстрый поиск от OPPO
com.oppoex.afterservice                     # Послегарантийное обслуживание (чат)
com.realme.movieshot                        # Combine captions ??? что-то связаное с видео
com.realme.wellbeing                        # Капсула сна
com.realmecomm.app                          # Комьюнити (форум)
#com.coloros.weather2                       # Погода, показывает текущую погоду в шторке под часами
#com.coloros.weather.service                # Сервис для Погоды, постоянно висит в памяти и лезет в интернет для обновления информации
#com.coloros.oshare                         # Realme Share, пункт в меню поделиться с другим аккаунтом на Heytap
#com.nearme.atlas                           # Гордое название Secure payment, на самом деле проверка на рут и блокировка приложений не из маркета
#com.oppo.atlas                             # Еще один атлас, уже от oppo, должен выполнять функции бесплатного антивируса
#com.coloros.activation                     # Пункт в меню о гарантийном талоне
#com.coloros.gamespace                      # Игровой центр, если не записываете игры, то смысла в нем нет, игры и без него отлично идут, а уведомления можно заблокировать и стандартными средствами

#  Telemetry
com.nearme.statistics.rom                   # Участие в тестировании, постоянно висит в памяти, сбор информации с телефона и отправка её разработчикам
com.trustonic.teeservice                    # Сервис "левой" компании, занимающейся защитой сбором информации
com.tencent.soter.soterserver               # Еще один китайский партнер, с кем тоже надо поделится информацией. К играм отношения не имеет

#  Other
com.opera.preinstall                        # Приблуда от Opera, активность не замечена, но и пользы никакой
com.android.stk                             # Меню SIM-карты, приложение для SIM, показывает рекламу от операторов в виде всплывающего окна
com.android.cellbroadcastreceiver           # Оповещение населения, должен показывать сообщения от МЧС, включая розыск людей, но у нас не работает
com.android.wallpaper.livepicker            # Живые обои
com.dropboxchmod                            # Предустановленное облако от партнеров

'@ -split "`r`n" `
| ForEach-Object {
    if ($_ -match '^\s*#  |^\s*$') {
        Write-Host $_ -ForegroundColor Green
    } elseif ($_ -match '^\s*([^ #]+)') {
        uninstall $Matches[1]
    }
}
