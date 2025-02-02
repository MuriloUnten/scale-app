import "package:scale_app/data/services/tables.dart";

class UserSQLiteModel {
    int? id;
    String firstName;
    String lastName;
    num height;
    String sex;
    String dateOfBirth;

    UserSQLiteModel({
        this.id,
        required this.firstName,
        required this.lastName,
        required this.height,
        required this.sex,
        required this.dateOfBirth,
    });

    factory UserSQLiteModel.fromMap(Map<String, Object?> map) {
        return UserSQLiteModel(
            id: map[userTable.id] as int?,
            firstName: map[userTable.firstName] as String,
            lastName: map[userTable.lastName] as String,
            height: map[userTable.height] as num,
            sex: map[userTable.sex] as String,
            dateOfBirth: map[userTable.dateOfBirth] as String,
        );
    }
}
