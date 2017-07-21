### Задача

Необходимо организовать режим технического обслуживания для определенной страницы сайта. Страницу необходимо переводить в режим технического обслуживания ежедневно на определенный временной промежуток, а потом возвращать все на место.

### Предполагаемое решение

Идея следующая:

1. Заводим для целевой страницы **термин (Term)** в **банке терминов (TermSet)** SharePoint. Попасть туда можно через *"Параметры сайта"* -> *"Управление банком терминов"*
    * Настраиваем термин: Вкладка *"Навигация"* - включаем режим *"Страница, управляемая терминами, с удобным URL-адресом"*
    * Настраиваем термин: Вкладка *Страницы на базе терминов* -> устанавливаем переключатель *Изменить конечную страницу для этого термина* и указываем целевую страницу, для которой вводим режим технического обслуживания
    * При необходимости указываем удобный URL-адрес для страницы (*к примеру, укажем удобный адрес www.example.com/page*)
2. Заводим страницу для режима техничского обслуживания. Настариваем на ней ведомления и тексты в духе "Сейчас страница находится в режиме обслуживания, заходите чуть позже"
3. По таймеру подменяем конечную страницу для термина */page* на страницу режима технического обслуживания
4. По таймеру возвращаем исходную страницу

### Примечания

1. Для начала необходимо настроить политику безопасности на веб-сервере таким образом, чтобы он мог запускать powershell-скрипты. Подробнее можете почитать [здесь](https://blogs.msdn.microsoft.com/pasen/2011/12/07/set-executionpolicy-windows-powershell-updated-your-execution-policy-successfully-but-the-setting-is-overridden-by-a-policy-defined-at-a-more-specific-scope/). Я остановился на варианте **RemoteSigned** для скоупов Process, CurrentUser, LocalMachine. MachinePolicy и UserPolicy остались установлены в Undefined.

2. Писать код советую в **PowerShellISE** - подстветка, автодополнение, отладка, удобно и т.д.

3. В ходе работы возникла следующая ошибка:

    Исключение при вызове "SetLocalCustomProperty" с "2" аргументами: "У текущего пользователя недостаточно разрешений на выполнение этой операции."

    Решилась проблема путем добавления текущего пользователя, под которым запускается скрипт, в группу **"Администраторы банка терминов"**. Сделать это можно все через то же меню **"Средство управления банками терминов"** из п. 1, выбрав корневой элемент в древовидной структуре слева (у меня она называется "Служба управления метаданных")

    Если у вас наблюдаются какие-либо проблемы с безопасностью и правами - читайте [эту](https://technet.microsoft.com/en-us/library/ee806878.aspx) статью.

3. В начале скрипта вызываем командлет **Add-PSSnapin "Microsoft.SharePoint.PowerShell"** для добавления возможностей по администрированию SharePoint в командной строке Powershell ( ведь запускать командную консоль SharePoint каждый раз не столь удобно :) )
4. Команда для запуска скрипта в планировщике заданий
    **powershell -file C:\scripts\abit-rating-active-mod.ps1**
    (*-file C:\scripts\abit-rating-active-mod.ps1 указывается в "добавить аргументы*)