import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:scale_app/data/services/ble_service.dart';

import 'dart:async';
import 'dart:convert';

class BLERepository {
    BLERepository({
        required BLEService bleService,
    }) : _bleService = bleService;

    final BLEService _bleService;

    // State
    BluetoothDevice? _connectedDevice;
    final StreamController<List<ScanResult>> _scanResultsController = StreamController.broadcast();
    final StreamController<List<int>> _notificationController = StreamController.broadcast();

    Stream<List<ScanResult>> get scanResultsStream => _scanResultsController.stream;
    Stream<List<int>> get notificationStream => _notificationController.stream;

    BluetoothDevice? getDevice() => _connectedDevice;
    BluetoothDevice? get device => _connectedDevice;
    bool get connected => _connectedDevice != null && _connectedDevice!.isConnected;
    String? get deviceName => _connectedDevice?.advName;

    final Guid _serviceUuid = Guid("12345678-1234-1234-1234-1234567890ab");
    final Guid _startBiaCharacteristicUuid = Guid("34567890-1234-1234-1234-1234567890ab");
    final Guid _readBiaCharacteristicUuid = Guid("23456789-1234-1234-1234-1234567890ab");

    BluetoothCharacteristic get _startBiaCharacteristic {
        if (!connected) {
            throw Exception("Device not connected");
        }
        
        return BluetoothCharacteristic(
            remoteId: _connectedDevice!.remoteId,
            serviceUuid: _serviceUuid,
            characteristicUuid: _startBiaCharacteristicUuid,
        );
    }

    BluetoothCharacteristic get _readBiaCharacteristic {
        if (!connected) {
            throw Exception("Device not connected");
        }
        
        return BluetoothCharacteristic(
            remoteId: _connectedDevice!.remoteId,
            serviceUuid: _serviceUuid,
            characteristicUuid: _readBiaCharacteristicUuid,
        );
    }

    Future<List<ScanResult>> scanForDevices() async {
        return _bleService.scanForDevices();
    }

    Future<void> connect(BluetoothDevice device) async {
        try {
            await _bleService.connect(device);
            _connectedDevice = device;
            print("Connected to device ${device.remoteId}");
        }
        on Exception catch (e) {
            throw Exception("Failed to connect to device. Error $e");
        }
    }

    Future<void> disconnect() async {
        if (_connectedDevice != null) {
            try {
                await _bleService.disconnect(_connectedDevice!);
                _connectedDevice = null;
            }
            on Exception catch (e) {
                print("failed to disconnect device");
            }
        }
    }

    
    Future<({double weight, double impedance})> getBia() async {
        if (!connected) {
            throw Exception("Device not connected");
        }
        
        try {
            await _bleService.writeCharacteristic(_startBiaCharacteristic, utf8.encode("start"));
            print("Measurement started. Waiting for response from scale");

            List<int> result = await _bleService
                .listenToNotifications(_readBiaCharacteristic)!
                .firstWhere((el) => el.isNotEmpty);
            print("Result received.\nResult: $result");
            
            String resultString = utf8.decode(result);
            print("Result received.\nResult: $resultString");

            var json = jsonDecode(resultString);

            double weight = double.parse(json["m"]);
            if (weight == 0) {
                weight = 50.0;
            }
            double impedance;
            if (json["Z"] != "inf") {
                impedance = double.parse(json["Z"]);
            } else {
                impedance = 1000;
            }
            ({double weight, double impedance}) measurements = (weight: weight, impedance: impedance);

            return measurements;
        }
        on Exception catch (e) {
            throw Exception("Failed to fetch BIA. Error: $e");
        }
    }

    Future<List<int>> readCharacteristic(BluetoothCharacteristic characteristic) async {
        return await _bleService.readCharacteristic(characteristic);
    }

    Future<void> writeCharacteristic(BluetoothCharacteristic characteristic, List<int> data) async {
        await _bleService.writeCharacteristic(characteristic, data);
    }

    void subscribeToNotifications(BluetoothCharacteristic characteristic) {
        _bleService.listenToNotifications(characteristic)?.listen((data) {
            _notificationController.add(data);
        });
    }
}
