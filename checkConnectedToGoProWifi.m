% CHECKCONNECTEDTOGOPROWIFI - check whether connected to the GoPro wifi
% If not connected, it will try to connect
%
% checkConnectedToGoProWifi(wifiname,password)
%
% wifiname is the name of the network (ideally without spaces), which can
% be setup on the GoPro app
%
% password is the password (can be seen in Preferences->Connections->Camera
% Info), only used on the Mac (on Windows need to first connect manually to
% the GoPro)
%
% Works with Windows and Mac
%
% After successfully runnning this, you can use GoProWifi to send commands
%
% returns 1 if successful, 0 if not

function success = checkConnectedToGoProWifi(wifiname,password)

success = 0;

if ispc  
    [~,result] = system('netsh WLAN show interfaces | grep ''There is no wireless interface on the system''');
    if ~isempty(result)
        uiwait(msgbox('The wifi is not activated or the wifi dongle in not connected - turn on wifi or plug in a wifi dongle.','modal'));
        return
    end
    
    [~,result] = system(['netsh WLAN show interfaces | grep SSID | grep ' wifiname]);
    if isempty(result)
        % Not connected - try to connect
        [~,result] = system(['netsh WLAN connect name=' wifiname]);
        
        % check again
        [~,result] = system(['netsh WLAN show interfaces | grep SSID | grep ' wifiname]);
        if isempty(result)
            uiwait(msgbox('The Gopro wifi is not connected. Make sure the gopro is awake, and the PC is connected to the gopro wifi.','modal'));
            return;
        else
            success = 1;
        end
    else
        success = 1;
    end
elseif ismac   
    [~,result] = system(['/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -s | grep ' wifiname]);
    if isempty(result)
        uiwait(msgbox('The Gopro wifi is not connected. Make sure the gopro is awake, and the computer is connected to the gopro wifi. ','modal'));
        return
    end

    [~,result] = system(['/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | grep '' SSID'' | grep ' wifiname]);
    if isempty(result)
        % Not connected - try to connect
        [~,result] = system(['networksetup -setairportnetwork en0 ' wifiname ' ' password]);
        
        % check again
        [~,result] = system(['/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | grep '' SSID'' | grep ' password]);
        if isempty(result)
            uiwait(msgbox('Could not connect to the gopro wifi. Make sure the gopro is awake, and the computer is connected to the gopro wifi. Will try again in 5 seconds','modal'));
        else
            success = 1;
        end
    else
        success = 1;
    end
else
    uiwait(msgbox('Unknown computer','modal'));
end