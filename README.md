# ABBDrives Test project

The project loads a list of forecasts from `forecast.plist` and shows them in plain table view. The application is built according to MVP guidelines and unit tests cover loading of the large data set, empty data set and several other edge cases.

### Testing

There are two scripts: `testrun_simulator.sh` and `testrun_iphone.sh`. In order to make them executable after repo checkout use `chmod +x \script_name\`. The script that run tests on real device should exactyly name the device, thus script must be edited to inlude your device name.