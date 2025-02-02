import "./sex.dart";
import "package:flutter_app_test/data/services/tables.dart";

class User {
    int? id;
    String firstName;
    String lastName;
    double height;
    Sex sex;
    DateTime dateOfBirth;

    String get fullName => "$firstName $lastName";
    int get age => (DateTime.now().difference(dateOfBirth).inDays / 365).toInt();


    User({
        this.id,
        required this.firstName,
        required this.lastName,
        required this.height,
        required this.sex,
        required this.dateOfBirth,
    });

    factory User.fromMap(Map<String, Object?> map) {
        return User(
            id: map[userTable.id] as int?,
            firstName: map[userTable.firstName] as String,
            lastName: map[userTable.lastName] as String,
            height: map[userTable.height] as double,
            sex: map[userTable.sex] as Sex,
            dateOfBirth: map[userTable.dateOfBirth] as DateTime,
        );
    }
}
