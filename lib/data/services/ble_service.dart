import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:async';

class BLEService {
    Future<List<ScanResult>> scanForDevices({Duration duration = const Duration(seconds: 5)}) async {
        List<ScanResult> results = [];
        FlutterBluePlus.scanResults.forEach((scanResult) {
            print("SCAN RESULT: $scanResult");
            for (var result in scanResult) {
                if (!(results.any((r) => r.device.remoteId == result.device.remoteId))) {
                    results.add(result);
                }
            }
        });

        FlutterBluePlus.scanResults.listen((List<ScanResult> scanData) {
            print("SCAN DATA: $scanData");
            for (var result in scanData) {
                if (!(results.any((r) => r.device.remoteId == result.device.remoteId))) {
                    results.add(result);
                }
            }
        });

        await FlutterBluePlus.startScan(timeout: duration);
        await Future.delayed(duration);
        await FlutterBluePlus.stopScan();
        return results;
    }

    Future<void> stopScan() async => await FlutterBluePlus.stopScan();

    Future<void> connect(BluetoothDevice device) async => await device.connect();

    Future<void> disconnect(BluetoothDevice device) async => await device.disconnect();

    Future<List<BluetoothService>> discoverServices(BluetoothDevice device) async {
        return await device.discoverServices();
    }

    Future<List<int>> readCharacteristic(BluetoothCharacteristic characteristic) async {
        return await characteristic.read();
    }

    Future<void> writeCharacteristic(BluetoothCharacteristic characteristic, List<int> data) async {
        await characteristic.write(data);
    }

    Stream<List<int>>? listenToNotifications(BluetoothCharacteristic characteristic) {
        characteristic.setNotifyValue(true);
        return characteristic.lastValueStream;
    }
}
