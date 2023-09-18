netsh wlan show profile

$infoWifiCmd = "netsh wlan show profile name=`"WIFI_NAME`" key=clear"
Set-Clipboard $infoWifiCmd

echo "`nRun following command: ", $infoWifiCmd
echo "And replace WIFI_NAME with wifi, which you want to target."
