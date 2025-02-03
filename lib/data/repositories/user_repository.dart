import "package:scale_app/domain/user.dart";
import "package:scale_app/data/services/models/user_sqlite_model.dart";
import "package:scale_app/domain/sex.dart";
import "package:scale_app/data/services/tables.dart";
import "package:scale_app/data/services/sqlite_storage.dart";
import "package:scale_app/utils/result.dart";

class UserRepository {
    UserRepository({
        required SQLiteStorage storage,
    }) : _storage = storage;

    final SQLiteStorage _storage;
    
    Future<Result<User>> createUser(User user) async {
        var result = await _storage.createUser(_userToDataModel(user));
        switch (result) {
            case Ok(): {
                await _storage.updateCurrentUser(result.value.id!);
                return Result.ok(_dataModelToUser(result.value));
            }
            case Error(): {
                return Result.error(Exception("Failed to Create User"));
            }
        }
    }

    Future<Result<User>> getUser(int id) async {
        var result = await _storage.getUser(id);
        switch (result) {
            case Ok(): {
                return Result.ok(_dataModelToUser(result.value));
            }
            case Error(): {
                return Result.error(Exception("Failed to fetch user with id = $id"));
            }
        }
    }

    Future<Result<User>> getCurrentUser() async {
        var result = await _storage.getCurrentUser();
        switch (result) {
            case Ok(): {
                return Result.ok(_dataModelToUser(result.value));
            }
            case Error(): {
                return Result.error(Exception("No current user registered"));
            }
        }
    }
    
    Future<Result<List<User>>> getUsers() async {
        var result = await _storage.getUsers();

        switch (result) {
            case Ok(): {
                List<User> users = [];
                for (var userData in result.value) {
                    users.add(_dataModelToUser(userData));
                }

                return Result.ok(users);
            }
            case Error(): {
                return Result.error(Exception("Failed to fetch users"));
            }
        }
        
    }

    Future<Result<User>> updateUser(User user) async {
        if (user.id == null) {
            return Result.error(Exception("User id cannot be null"));
        }

        var result = await _storage.updateUser(user.id!, _userToDataModel(user));

        switch (result) {
            case Ok(): {
                return Result.ok(_dataModelToUser(result.value));
            }
            case Error(): {
                return Result.error(result.error);
            }
        }
    }

    Future<Result<void>> updateCurrentUser(int id) async {
        var result = await _storage.updateCurrentUser(id);

        return result;
    }

    Future<Result<void>> deleteUser(int id) async {
        var result = await _storage.deleteUser(id);

        switch (result) {
            case Ok(): {
                return Result.ok(null);
            }
            case Error(): {
                return Result.error(Exception("Failed to delete user with id = $id"));
            }
        }
    }

    UserSQLiteModel _userToDataModel(User user) {
        return UserSQLiteModel.fromMap({
            userTable.id: user.id,
            userTable.firstName: user.firstName,
            userTable.lastName: user.lastName,
            userTable.height: user.height,
            userTable.sex: SexUtil(user.sex).string,
            userTable.dateOfBirth: user.dateOfBirth.toString(),
        });
    }

    User _dataModelToUser(UserSQLiteModel userData) {
        return User.fromMap({
            userTable.id: userData.id,
            userTable.firstName: userData.firstName,
            userTable.lastName: userData.lastName,
            userTable.height: userData.height.toDouble(),
            userTable.sex: SexUtil.fromString(userData.sex),
            userTable.dateOfBirth: DateTime.parse(userData.dateOfBirth),
        });
    }
}
