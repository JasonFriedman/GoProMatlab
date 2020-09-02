% GETDEVICEINFORMATION - Get some information about the GoPro device
%
% deviceInformationn = getDeviceInformation(b)
%
% b is the ble object, and can be obtained from connectToGoProBluetooth 

function deviceInformation = getDeviceInformation(b)

servicenames = {'Device Information','Device Information',...
    'Device Information','Device Information','Device Information',...
    'Device Information','Device Information','Device Information'};

charnames = {'Manufacturer Name String','Model Number String',...
    'Serial Number String','Hardware Revision String',...
    'Firmware Revision String','Software Revision String',...
    'System ID','PnP ID'};

for k=1:numel(servicenames)
    c = characteristic(b,servicenames{k},charnames{k});
    data = read(c);
    deviceInformation.(strrep(charnames{k},' ','_')) = char(data);
end
    