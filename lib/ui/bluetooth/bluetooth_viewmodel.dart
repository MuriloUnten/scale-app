import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:scale_app/data/repositories/ble_repository.dart';

import 'package:flutter/material.dart';

class BluetoothViewmodel extends ChangeNotifier {
    BluetoothViewmodel({
        required BLERepository bleRepository,
    }) : _bleRepository = bleRepository {
        scanCommand = Command.createAsyncNoParam(
            _scan,
            debugName: "Scan",
            initialValue: [],
        );
        connectCommand = Command.createAsyncNoResult(
            _connect,
            debugName: "ConnectDevice"
        );
        getStatusConnected = Command.createSyncNoParam( _getStatusConnected, initialValue: false)..execute();

        Timer.periodic(Duration(seconds: 2), (timer) {
            getStatusConnected.execute();
        });
    }

    bool get connected => _bleRepository.connected;

    String? get deviceName => _bleRepository.deviceName;

    final BLERepository _bleRepository;

    late Command<void, List<ScanResult>> scanCommand;
    late Command<BluetoothDevice, void> connectCommand;
    late Command<void, bool> getStatusConnected;

    Future<List<ScanResult>> _scan() async {
        return await _bleRepository.scanForDevices();
    }

    Future<void> _connect(BluetoothDevice device) async {
        await _bleRepository.connect(device);
    }

    bool _getStatusConnected() {
        return _bleRepository.connected;
    }
    
}
