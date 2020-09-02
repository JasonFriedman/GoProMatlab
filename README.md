# GoProMatlab
A library for controlling the GoPro through Matlab with bluetooth and wifi

The code is based on the excellent unoffical GoPro API at https://github.com/KonradIT/goprowifihack

Note that to use bluetooth (BLE), Matlab 2019b or greater is required.

The code has been tested on Mac and Windows

A sample bluetooth session to record video for 5 seconds:

[b,c] = connectToGoProBluetooth;
GoProBluetooth(c,'VideoMode');<BR>
GoProBluetooth(c,'Trigger');<BR>
pause(5);<BR>
GoProBluetooth(c,'Stop');

A sample wifi session to record video for 5 seconds and copy the file over:
[b,c] = turnOnWifiUsingBluetooth;<BR>
checkConnectedToGoProWifi('HERO7'); % Replace this with the name of your camera<BR>
GoProWifi('VideoMode');<BR>
GoProWifi('Trigger');<BR>
pause(5);<BR>
GoProWifi('Stop')<BR>
pause(2); % Need to give it time after stopping<BR>
fn = readmedia(1);<BR>
[dirname,name,ext] = fileparts(fn);<BR>
downloadfile(dirname,[name ext])

Function list:
checkConnectedToGoProWifi - make sure the GoPro is connected via wifi<BR>
connectToGoProBluetooth - connect to the GoPro via bluetooth<BR>
downloadfile - download a file over wifi from the GoPro<BR>
getDeviceInformation - get some basic information about the device<BR>
GoProBluetooth - send a command via bluetooth<BR>
GoProSetDateTime - set the date and time<BR>
GoProWifi - send a command via wifi<BR>
readmedia - read the list of media on the SD card<BR>
turnOnWifiUsingBluetooth - turn on wifi using bluetooth<BR>

This project is also on [![View GoProMatlab on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/79820-gopromatlab)






