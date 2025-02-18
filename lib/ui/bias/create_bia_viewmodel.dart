import 'package:scale_app/data/repositories/bia_repository.dart';
import 'package:scale_app/data/repositories/ble_repository.dart';
import 'package:scale_app/data/repositories/user_repository.dart';
import 'package:scale_app/domain/bia.dart';
import 'package:scale_app/domain/user.dart';
import 'package:scale_app/utils/result.dart';

import 'package:flutter_command/flutter_command.dart';
import 'package:flutter/material.dart';

class CreateBiaViewmodel extends ChangeNotifier {
    CreateBiaViewmodel({
        required BiaRepository biaRepository,
        required BLERepository bleRepository,
        required UserRepository userRepository,
    }) :
    _biaRepository = biaRepository,
    _bleRepository = bleRepository,
    _userRepository = userRepository {
        loadUserCommand = Command.createAsyncNoParamNoResult(
            _loadUser,
        )..execute();

        measureCommand = Command.createAsyncNoParam(
            _measure,
            debugName: "Measure",
            initialValue: null,
        );

        saveBiaCommand = Command.createAsyncNoParam(
            _saveBia,
            initialValue: Result.error(Exception("saving")),
        );
    }

    late Command<void, void> loadUserCommand;
    late Command<void, dynamic> measureCommand;
    late Command<void, Result<Bia>> saveBiaCommand;

    Bia? _measuredBia;
    Bia? get bia => _measuredBia;
    User? _user;

    final BiaRepository _biaRepository;
    final BLERepository _bleRepository;
    final UserRepository _userRepository;

    Future<void> _loadUser() async {
        //TODO remove this print statememnt
        print("CONNECTED DEVICE: ${_bleRepository.device}");
        final result = await _userRepository.getCurrentUser();
        switch (result) {
            case Ok(): {
                _user = result.value;
            }
            case Error(): {
                throw Exception("Failed to fetch user");
            }
        }
    }

    Future<Bia> _measure() async {
        ({double weight, double impedance}) measurements = await _bleRepository.getBia();
        _measuredBia = Bia.fromMeasurement(_user!, measurements.weight, measurements.impedance);
        return _measuredBia!;
    }

    Future<Result<Bia>> _saveBia() async {
        if (_measuredBia == null) {
            return Result.error(Exception("Measured BIA is null"));
        }

        final result = await _biaRepository.createBia(_measuredBia!);
        switch (result) {
            case Ok(): {
                _measuredBia = result.value;
                return Result.ok(result.value);
            }
            case Error(): {
                return result;
            }
        }
    }
}
