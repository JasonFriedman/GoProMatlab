% GOPROSETDATETIME - set the date and time on the GoPro via wifi
%
% GoProSetDateTime(thetime)
%
% thetime is a "date number", as returned by the function now
% the default is to call the function now for the current time
%
% Need to be already connected to the GoPro wifi (see checkConnectedToGoProWifi)

function GoProSetDateTime(thetime)

if nargin<1 || isempty(thetime)
    thetime = now;
end

try
    webread(sprintf('http://10.5.5.9/gp/gpControl/command/setup/date_time?p=%%%s%%%s%%%s%%%s%%%s%%%s',...
        dec2hex(str2double(datestr(thetime,'yy')),2), ... % year (2 digits)
        dec2hex(str2double(datestr(thetime,'mm')),2), ... % month (2 digits)
        dec2hex(str2double(datestr(thetime,'dd')),2), ... % day (2 digits)
        dec2hex(str2double(datestr(thetime,'HH')),2), ... % hour (2 digits)
        dec2hex(str2double(datestr(thetime,'MM')),2), ... % minute (2 digits)
        dec2hex(str2double(datestr(thetime,'SS')),2))); ... % second (2 digits)

        % day (2 digits)
catch ME
    if (strcmp(ME.identifier,'MATLAB:webservices:Timeout'))
        error('Cannot connect to GoPro. Make sure you are connected to the GoPro wifi');
    else
        rethrow(ME)
    end
end