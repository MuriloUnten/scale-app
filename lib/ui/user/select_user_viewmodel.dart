import 'dart:collection';

import 'package:flutter_command/flutter_command.dart';
import 'package:scale_app/data/repositories/user_repository.dart';

import 'package:flutter/material.dart';
import 'package:scale_app/domain/user.dart';
import 'package:scale_app/utils/result.dart';

class SelectUserViewmodel extends ChangeNotifier {
    SelectUserViewmodel({required UserRepository userRepository}) :
    _userRepository = userRepository {
        getUsers = Command.createAsyncNoParam<Result<List<User>>>(
            _getUsers,
            debugName: "GetUsers",
            initialValue: Result.error(Exception("loading")),
        )..execute();

        chooseUser = Command.createAsync<int, Result<void>>(
            _chooseUser,
            debugName: "ChooseUser",
            initialValue: Result.error(Exception("loading")),
        );
    }

    late Command<void, Result<List<User>>> getUsers;
    late Command<int, Result<void>> chooseUser;

    final UserRepository _userRepository;

    List<User> _users = [];
    UnmodifiableListView<User> get users => UnmodifiableListView(_users);

    Future<Result<List<User>>> _getUsers() async {
        var result = await _userRepository.getUsers();
        switch (result) {
            case Ok(): {
                _users = result.value;
            }
            case Error(): {

            }
        }
        return result;
    }

    Future<Result<void>> _chooseUser(int id) async {
        return await _userRepository.updateCurrentUser(id);
    }
}
