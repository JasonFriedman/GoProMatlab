% DOWNLOADFILE - Download a file off the sd card of the go pro via wifi
%
% saved = downloadfile(dirname,filename,savefile)

function saved = downloadfile(dirname,filename,savefile)

url = ['http://10.5.5.9:8080/videos/DCIM/' dirname '/' filename];
if nargin<3 || isempty(savefile)
    savefile = ['./' filename];
end

saved = websave(savefile,url);


