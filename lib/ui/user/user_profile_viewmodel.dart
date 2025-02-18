import 'package:scale_app/domain/user.dart';
import 'package:scale_app/data/repositories/user_repository.dart';

import 'package:flutter/material.dart';
import 'package:scale_app/utils/result.dart';
import 'package:flutter_command/flutter_command.dart';

class UserProfileViewmodel extends ChangeNotifier {
    UserProfileViewmodel({
        required UserRepository userRepository,
    }) : _userRepository = userRepository {
        load = Command.createAsyncNoParam(
            _load,
            debugName: "LoadUserProfile",
            initialValue: Result.error(Exception("loading"))
        )..execute();

        logout = Command.createAsyncNoParam(
            _logout,
            debugName: "Logout",
            initialValue: Result.error(Exception("loading"))
        );
    }

    late Command<void, Result<User>> load;
    late Command<void, Result<void>> logout;

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

    Future<Result<void>> _logout() async {
        return await _userRepository.logout();
    }
}
