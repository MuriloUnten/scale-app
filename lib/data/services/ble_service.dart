import 'package:flutter_command/flutter_command.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEService {

    late Command<void, List<ScanResult>> scanCommand;
    late Command<BluetoothDevice, void> connectCommand;
    late Command<void, void> disconnectCommand;
    late Command<void, List<int>> readCommand;
    late Command<List<int>, void> writeCommand;

    BluetoothDevice? _connectedDevice;
    BluetoothCharacteristic? _targetCharacteristic;

    BLEService() {
        // Command to scan for BLE devices
        scanCommand = Command.createAsyncNoParam<List<ScanResult>>(
            _scanForDevices,
            initialValue: [],
        )..execute();

        // Command to connect to a BLE device
        connectCommand = Command.createAsyncNoResult<BluetoothDevice>(
            _connectToDevice,
        );

        // Command to disconnect from a device
        disconnectCommand = Command.createAsyncNoParamNoResult(
            _disconnect,
        );

        // Command to read data from characteristic
        readCommand = Command.createAsyncNoParam<List<int>>(
            _readData,
            initialValue: [],
        );

        // Command to write data to characteristic
        writeCommand = Command.createAsyncNoResult<List<int>>(
            _writeData,
        );
    }

    // Scans for devices and returns the list of ScanResults
    Future<List<ScanResult>> _scanForDevices() async {
        print("INSIDE _SCANFORDEVICES");
        if (! await FlutterBluePlus.isSupported) {
            print("BLUETOOTH NOT SUPPORTED");
            return [];
        }
        if (! await FlutterBluePlus.isOn) {
            print("BLUETOOTH OFF");
        }
        FlutterBluePlus.startScan(timeout: const Duration(seconds: 5));
        await Future.delayed(const Duration(seconds: 5)); // Wait for results
        return FlutterBluePlus.scanResults.first;
    }

    // Connects to a selected Bluetooth device
    Future<void> _connectToDevice(BluetoothDevice device) async {
        _connectedDevice = device;
        await device.connect();
        await _discoverServices(device);
    }

    // Disconnects from the connected device
    Future<void> _disconnect() async {
        await _connectedDevice?.disconnect();
        _connectedDevice = null;
        _targetCharacteristic = null;
    }

    // Discover services & find target characteristic
    Future<void> _discoverServices(BluetoothDevice device) async {
        List<BluetoothService> services = await device.discoverServices();
        for (var service in services) {
            for (var characteristic in service.characteristics) {
                if (characteristic.properties.read || characteristic.properties.write) {
                    _targetCharacteristic = characteristic;
                    break;
                }
            }
        }
    }

    // Reads data from the characteristic
    Future<List<int>> _readData() async {
        if (_targetCharacteristic != null) {
            return await _targetCharacteristic!.read();
        }
        return [];
    }

    // Writes data to the characteristic
    Future<void> _writeData(List<int> data) async {
        if (_targetCharacteristic != null) {
            await _targetCharacteristic!.write(data);
        }
    }
}
