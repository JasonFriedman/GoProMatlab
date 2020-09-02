% GOPRO bluetooth commands - subset of commands from https://github.com/KonradIT/gopro-ble-py/blob/master/commands.py
% Requires Matlab 2019b or higher
%
% goproBluetooth(c,command)
% 
% c is a bluetooth characteristic (can be obtained using the function
% connectToGoProBluetooth)
%
% c is a command, one of:
% 'Trigger', 'Stop', 'VideoMode','PhotoMode','MultiShot',...
% 'PowerOff','PowerOffForce','HiLightTag','LocateOn','LocateOff','WifiOn','WifiOff'
%
% For other capabilities, see the wifi commands (goProWifi)

function GoProBluetooth(c,command)

commands = {'Trigger', 'Stop', 'VideoMode','PhotoMode','MultiShot',...
    'PowerOff','PowerOffForce','HiLightTag','LocateOn','LocateOff','WifiOn','WifiOff'};

calls = {[0x03 0x01 0x01 0x01],[0x03 0x01 0x01 0x00],[0x03 0x02 0x01 0x00],[ 0x03 0x02 0x01 0x01],[0x03 0x02 0x01 0x02],...
    	[0x01 0x05],[0x01 0x04],[ 0x01 0x18],[0x03 0x16 0x01 0x01],[0x03 0x16 0x01 0x00],[0x03 0x17 0x01 0x01],[0x03 0x17 0x01 0x00],...    
    };
    

if nargin==0
    fprintf('Available commands:\n\n');
    for k=1:numel(commands)
        fprintf('%s\n',commands{k});
    end
    return
end

if ~isa(c,'matlabshared.blelib.Characteristic')
    error('The first argument c must be a bluetooth characteristic');
end

commandnum = find(strcmp(command,commands));

if isempty(commandnum)
    error(['Unknown command ' command]);
end

write(c,calls{commandnum},'uint8');
