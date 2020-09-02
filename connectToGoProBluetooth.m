% CONNECTTOGOPROBLUETOOTH - connect to the GoPro bluetooth
% 
% [b,c] = connectToGoProBluetooth(name)
% optionally specify the name (default = GoPro), e.g. if you have more than 1 GoPro
% otherwise, the first GoPro in the list will be selected
%
% To find the names, run blelist in the command window
%
% To connect, the camera must be in Preferences -> Connections -> Connect Device -> GoPro App
% (after connecting you can return to the "regular" camera)
%
% Returns the ble connection b and the characteristic c
% c can be used with the function GoProBluetooth to control the device
%
% Requires Matlab 2019b or higher

function [b,c] = connectToGoProBluetooth(name)

if nargin<1 || isempty(name)
    name = 'GoPro';
end

devices = blelist('Name',name,'Timeout',10);

if isempty(devices)
    error('Cannot find GoPro via BLE. Make sure camera is on, and in Preferences -> Connections -> Connect Device -> GoPro App');
end

b = ble(devices.Name(1));
c = characteristic(b,"FEA6","B5F90072-AA8D-11E3-9046-0002A5D5C51B");

