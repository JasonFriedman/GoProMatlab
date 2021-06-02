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

function errorMessage = GoProWifi(command)

[commands,calls] = getCommands;

errorMessage = [];

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
    if nargout
        errorMessage = ME;
    elseif strcmp(ME.identifier,'MATLAB:webservices:Timeout')
        error('Cannot connect to GoPro. Make sure you are connected to the GoPro wifi');
    else
        rethrow(ME)
    end
end