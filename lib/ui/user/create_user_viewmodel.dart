import 'package:flutter_app_test/data/repositories/user_repository.dart';
import 'package:flutter_app_test/domain/sex.dart';
import 'package:flutter_app_test/domain/user.dart';

import 'package:flutter_app_test/utils/result.dart';
import 'package:flutter_app_test/utils/format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';

class CreateUserViewmodel extends ChangeNotifier {
    CreateUserViewmodel({
        required UserRepository userRepository,
    }) :
    _userRepository = userRepository {
        createUser = Command.createAsync<(String, String, String, String, String), Result<User>>(
            _createUser,
            initialValue: Result.error(Exception("loading")),
        );
    }

    late Command<(String, String, String, String, String), Result<User>> createUser;

    final UserRepository _userRepository;

    User? _user;
    User? get user => _user;
    
    Future<Result<User>> _createUser(
    (String firstNameStr, String lastNameStr, String dateOfBirthStr, String sexStr, String heightStr) userData) async {
        var (firstNameStr, lastNameStr, dateOfBirthStr, sexStr, heightStr) = userData;

        DateTime dateOfBirth = parseFormattedDate(dateOfBirthStr);
        Sex sex = SexUtil.fromString(sexStr);
        double height = double.parse(heightStr);

        _user = User(
            firstName: firstNameStr,
            lastName: lastNameStr,
            height: height,
            sex: sex,
            dateOfBirth: dateOfBirth
        );

        var result = await _userRepository.createUser(_user!);
        switch (result) {
            case Ok(): {
                _user!.id = result.value.id;
                return Result.ok(_user!);
            }
            case Error(): {
                return result;
            }
        }
    }
}
