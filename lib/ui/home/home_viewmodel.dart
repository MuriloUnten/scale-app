import 'dart:collection';

import 'package:scale_app/data/repositories/bia_repository.dart';
import 'package:scale_app/data/repositories/ble_repository.dart';
import 'package:scale_app/data/repositories/user_repository.dart';
import 'package:scale_app/domain/bia.dart';
import 'package:scale_app/domain/user.dart';

import 'package:flutter_command/flutter_command.dart';
import 'package:flutter/material.dart';
import 'package:scale_app/utils/result.dart';

class HomeViewmodel extends ChangeNotifier {
    HomeViewmodel({
        required UserRepository userRepository,
        required BiaRepository biaRepository,
        required BLERepository bleRepository,
    }) :
    _userRepository = userRepository,
    _biaRepository = biaRepository,
    _bleRepository = bleRepository {
        load = Command.createAsyncNoParam<Result<void>>(
            _load,
            debugName: "LoadHome",
            initialValue: Result.error(Exception("loading"),
        ))..execute();
    }

    late Command<void, Result<void>> load;
    
    final UserRepository _userRepository;
    final BiaRepository _biaRepository;
    final BLERepository _bleRepository;

    User? _user;
    User? get user => _user;

    List<Bia> _recentBias = [];
    UnmodifiableListView<Bia> get recentBias => UnmodifiableListView(_recentBias.take(3));

    bool get btConnected => _bleRepository.connected;

    Future<Result<void>> _load() async {
        var userResult = await _userRepository.getCurrentUser();
        switch (userResult) {
            case Error(): {
                _user = null;
                return userResult;
            }
            case Ok(): {
                _user = userResult.value;
            }
        }

        var biasResult = await _biaRepository.getBias();
        switch (biasResult) {
            case Error(): {
                throw biasResult.error;
            }
            case Ok(): {
                _recentBias = biasResult.value;
            }
        }

        return Result.ok(null);
    }
}
