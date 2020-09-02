% TURNONWIFIUSINGBLUETOOTH - Turn on wifi on GoPro using bluetooth
%
% [b,c] = turnOnWifiUsingBluetooth(name,showMessage)
%
% For some models, the camera may need to be in Preferences -> Connections -> Connect Device -> GoPro App
% (after connecting you can return to the "regular" camera)
%
%
% optionally specify the name (default = GoPro), e.g. if you have more than 1 GoPro
%
% If show message = 1 (default 0), it will ask  to return to the regular
% mode so that wifi can be turned on
%
% To find the names, run blelist in the command window

function [b,c] = turnOnWifiUsingBluetooth(name,showMessage)

if nargin<1 || isempty(name)
    name = 'GoPro';
end

if nargin<2 || isempty(showMessage)
    showMessage = 0;
end

[b,c] = connectToGoProBluetooth(name);


% This only seems to work when back in "regular" mode (i.e.  not in connect
% to app)
if showMessage
    uiwait(msgbox('Return GoPro to regular mode','Return','modal'));
end
GoProBluetooth(c,'WifiOn')