# GoProMatlab
A library for controlling the GoPro through Matlab with bluetooth and wifi

The code is based on the excellent unoffical GoPro API at https://github.com/KonradIT/goprowifihack

Note that to use bluetooth (BLE), Matlab 2019b or greater is required.

The code has been tested on Mac and Windows

A sample bluetooth session to record video for 5 seconds:

[b,c] = connectToGoProBluetooth;
GoProBluetooth(c,'VideoMode');
GoProBluetooth(c,'Trigger');
pause(5);
GoProBluetooth(c,'Stop');

A sample wifi session to record video for 5 seconds and copy the file over:
[b,c] = turnOnWifiUsingBluetooth;
checkConnectedToGoProWifi('HERO7'); % Replace this with the name of your camera
GoProWifi('VideoMode');
GoProWifi('Trigger');
pause(5);
GoProWifi('Stop')
pause(2); % Need to give it time after stopping
fn = readmedia(1);
[dirname,name,ext] = fileparts(fn);
downloadfile(dirname,[name ext])

Function list:
checkConnectedToGoProWifi - make sure the GoPro is connected via wifi
connectToGoProBluetooth - connect to the GoPro via bluetooth
downloadfile - download a file over wifi from the GoPro
getDeviceInformation - get some basic information about the device
GoProBluetooth - send a command via bluetooth
GoProSetDateTime - set the date and time
GoProWifi - send a command via wifi
readmedia - read the list of media on the SD card
turnOnWifiUsingBluetooth - turn on wifi using bluetooth

[![View GoProMatlab on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/79820-gopromatlab)






