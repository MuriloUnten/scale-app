import 'package:flutter_app_test/domain/user.dart';
import 'package:flutter_app_test/data/repositories/user_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/utils/result.dart';
import 'package:flutter_command/flutter_command.dart';

class UserProfileViewmodel extends ChangeNotifier {
    UserProfileViewmodel({
        required UserRepository userRepository,
    }) : _userRepository = userRepository {
        load = Command.createAsyncNoParam(_load, initialValue: Result.error(Exception("loading")))..execute();
    }

    late Command<void, Result<User>> load;

    User? _user;
    User? get user => _user;

    final UserRepository _userRepository;

    Future<Result<User>> _load() async {
        var result =  await _userRepository.getCurrentUser();
        switch (result) {
            case Ok(): {
                _user = result.value;
            }
            case Error(): {
            }
        }
        return result;
    }
}
