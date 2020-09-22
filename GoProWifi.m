% GOPROWIFI - send a command to the GoPro via wifi
% This is a subset of commands from https://github.com/KonradIT/goprowifihack/blob/master/HERO7/HERO7-Commands.md
%
% You must be already connected to the GoPro wifi for this to work
%
% GoProWifi(command)
% command is one of:
% 'Trigger','Stop','VideoMode','PhotoMode','MultiShot'
% '4K','4K 4:3','2.7K','2.7K 4:3','1440p','1080p','960p','720p'
% '240fps','120fps','100fps','90fps','80fps','60fps','50fps','48fps','30fps','25fps'
% 'Wide','SuperView','Linear','4:3','16:9'
% 'TagMoment','LocateOn','LocateOff','PowerOff',...
% 'AutoOffNever','AutoOff1m','AutoOff2m','AutoOff3m','AutoOff5m'
% 'GyroBased','Up','Down'

function GoProWifi(command)

commands = {'Trigger',            'Stop',               'VideoMode',       'PhotoMode',        'MultiShot',...
    '4K','4K 4:3','2.7K','2.7K 4:3','1440p','1080p','960p','720p',...
    '240fps','120fps','100fps','90fps','80fps','60fps','50fps','48fps','30fps','25fps',...
    'Wide','SuperView','Linear',...
    '4:3','16:9','TagMoment','LocateOn','LocateOff','PowerOff',...
    'AutoOffNever','AutoOff1m','AutoOff2m','AutoOff3m','AutoOff5m',...
    'GyroBased','Up','Down'};

calls =  {'command/shutter?p=1','command/shutter?p=0','command/mode?p=0','command/mode?p=1', 'command/mode?p=2',...
    'setting/2/1','setting/2/18','setting/2/4','setting/2/3','setting/2/7','setting/2/9','setting/2/10','setting/2/12',...
    'setting/3/0','setting/3/1','setting/3/2','setting/3/3','setting/3/4','setting/3/5','setting/3/6','setting/3/7','setting/3/8','setting/3/9',...
    'setting/4/0','setting/4/3','setting/4/4',...
    'setting/108/0','setting/108/1','commannd/storage/tag_moment','command/system/locate?p=1','command/system/locate?p=0','command/system/sleep',...
    'setting/59/0','setting/59/1','setting/59/2','setting/59/3','setting/59/4',...
    'setting/112/0','setting/112/1','setting/112/2'};

if nargin==0
    fprintf('Available commands:\n\n');
    for k=1:numel(commands)
        fprintf('%s\n',commands{k});
    end
    return
end

commandnum = find(strcmp(command,commands));

if isempty(commandnum)
    error(['Unknown command ' command]);
end

try
    webread(['http://10.5.5.9/gp/gpControl/' calls{commandnum}]);
catch ME
    if (strcmp(ME.identifier,'MATLAB:webservices:Timeout'))
        error('Cannot connect to GoPro. Make sure you are connected to the GoPro wifi');
    else
        rethrow(ME)
    end
end