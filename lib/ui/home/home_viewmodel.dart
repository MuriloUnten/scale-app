import 'dart:collection';

import 'package:flutter_app_test/data/repositories/bia_repository.dart';
import 'package:flutter_app_test/data/repositories/user_repository.dart';
import 'package:flutter_app_test/domain/bia.dart';
import 'package:flutter_app_test/domain/user.dart';

import 'package:flutter_command/flutter_command.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_test/utils/result.dart';

class HomeViewmodel extends ChangeNotifier {
    HomeViewmodel({
        required UserRepository userRepository,
        required BiaRepository biaRepository,
    }) :
    _userRepository = userRepository,
    _biaRepository = biaRepository {
        load = Command.createAsyncNoParam<Result<void>>(_load, initialValue: Result.error(Exception("loading")))..execute();
    }

    late Command<void, Result<void>> load;
    
    final UserRepository _userRepository;
    final BiaRepository _biaRepository;

    User? _user;
    User? get user => _user;

    List<Bia> _recentBias = [];
    UnmodifiableListView<Bia> get recentBias => UnmodifiableListView(_recentBias);

    Future<Result<void>> _load() async {
        print("insinde _load");
        var time = DateTime.now();
        print("Time now ${time.toString()}");
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
        print("after user");

        var biasResult = await _biaRepository.getBias();
        switch (biasResult) {
            case Error(): {
                throw biasResult.error;
            }
            case Ok(): {
                _recentBias = biasResult.value;
            }
        }
        print("after bias");

        return Result.ok(null);
    }
}
