import 'package:scale_app/data/services/models/user_sqlite_model.dart';
import 'package:scale_app/data/services/models/bia_sqlite_model.dart';
import 'package:scale_app/data/services/tables.dart';
import 'package:scale_app/utils/result.dart';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SQLiteStorage {
  static final SQLiteStorage instance = SQLiteStorage._constructor();
  static Database? _db;

  static final databaseName = "scale.db";

  /* ------------------------------------- */
  /* --------- Database Creation --------- */
  /* ------------------------------------- */
  SQLiteStorage._constructor();

  Future<Database> get database async {
    _db ??= await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final directoryPath = await getDatabasesPath();
    final databasePath = join(directoryPath, databaseName);
    final database = await openDatabase(
      databasePath,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
            CREATE TABLE ${userTable.table} (
                ${userTable.id} INTEGER PRIMARY KEY NOT NULL,
                ${userTable.firstName} TEXT NOT NULL,
                ${userTable.lastName} TEXT NOT NULL,
                ${userTable.height} DECIMAL(3,2) NOT NULL,
                ${userTable.sex} INTEGER NOT NULL,
                ${userTable.dateOfBirth} TEXT NOT NULL
            );
            ''');
        await db.execute('''
            CREATE TABLE ${biaTable.table} (
                ${biaTable.id} INTEGER PRIMARY KEY NOT NULL,
                ${biaTable.userId} INTEGER NOT NULL,
                ${biaTable.timestamp} TEXT NOT NULL,
                ${biaTable.weight} FLOAT NOT NULL,
                ${biaTable.muscleMass} FLOAT NOT NULL,
                ${biaTable.fatMass} FLOAT NOT NULL,
                ${biaTable.waterMass} FLOAT NOT NULL,
                FOREIGN KEY (${biaTable.userId}) REFERENCES ${userTable.table} (${biaTable.userId})
            );
            ''');
        await db.execute('''
            CREATE TABLE ${currentUserTable.table} (
                ${currentUserTable.userId} INTEGER PRIMARY KEY NOT NULL
            );
            ''');
      },
    );

    return database;
  }

  /* ------------------------------------- */
  /* ------------- Endpoints ------------- */
  /* ------------------------------------- */
  Future<Result<UserSQLiteModel>> createUser(UserSQLiteModel user) async {
    final db = await database;

    try {
      user.id = await db.insert(userTable.table, {
        userTable.firstName: user.firstName,
        userTable.lastName: user.lastName,
        userTable.height: user.height,
        userTable.sex: user.sex,
        userTable.dateOfBirth: user.dateOfBirth,
      });

      return Result.ok(user);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<int>> _getCurrentUserId() async {
    final db = await database;

    try {
      var result = await db.query(currentUserTable.table, columns: [
        currentUserTable.userId,
      ]);
      var resultMap = result.singleOrNull;
      if (resultMap == null) {
        return Result.error(Exception("No current user"));
      }

      return Result.ok(resultMap[currentUserTable.userId] as int);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<UserSQLiteModel>> getCurrentUser() async {
    final db = await database;

    try {
      var resultUserId = await _getCurrentUserId();
      late int userId;
      switch (resultUserId) {
        case Ok():
          {
            userId = resultUserId.value;
          }
        case Error():
          {
            return Result.error(Exception("No current user"));
          }
      }

      var result = await db.query(
        userTable.table,
        columns: [
          userTable.id,
          userTable.firstName,
          userTable.lastName,
          userTable.height,
          userTable.sex,
          userTable.dateOfBirth,
        ],
        where: "${userTable.id} = ?",
        whereArgs: [userId],
      );

      UserSQLiteModel user = UserSQLiteModel.fromMap(result.singleOrNull!);
      return Result.ok(user);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<UserSQLiteModel>> getUser(id) async {
    final db = await database;

    try {
      var result = await db.query(
        userTable.table,
        columns: [
          userTable.firstName,
          userTable.lastName,
          userTable.height,
          userTable.sex,
          userTable.dateOfBirth,
        ],
        where: "${userTable.id} = ?",
        whereArgs: [id],
      );

      UserSQLiteModel user = UserSQLiteModel.fromMap(result.singleOrNull!);
      return Result.ok(user);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<List<UserSQLiteModel>>> getUsers() async {
    final db = await database;

    try {
      var result = await db.query(
        userTable.table,
        columns: [
          userTable.id,
          userTable.firstName,
          userTable.lastName,
          userTable.height,
          userTable.sex,
          userTable.dateOfBirth,
        ],
      );

      List<UserSQLiteModel> users = [];
      for (var u in result) {
        var user = UserSQLiteModel.fromMap(u);
        users.add(user);
      }

      return Result.ok(users);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<UserSQLiteModel>> updateUser(
      int id, UserSQLiteModel newData) async {
    final db = await database;

    try {
      int changes = await db.update(
        userTable.table,
        {
          userTable.firstName: newData.firstName,
          userTable.lastName: newData.lastName,
          userTable.height: newData.height,
          userTable.sex: newData.sex,
          userTable.dateOfBirth: newData.dateOfBirth,
        },
        where: "${userTable.id} = ?",
        whereArgs: [id],
      );

      if (changes == 0) {
        return Result.error(Exception("User doesn't exist. Failed to update."));
      }

      newData.id = id;
      return Result.ok(newData);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> updateCurrentUser(int id) async {
    final db = await database;

    try {
      await db.delete(currentUserTable.table);
      await db.insert(
        currentUserTable.table,
        {currentUserTable.userId: id},
      );
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> deleteUser(int id) async {
    final db = await database;

    try {
      await db.delete(
        userTable.table,
        where: "${userTable.id} = ?",
        whereArgs: [id],
      );

      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> logout() async {
    final db = await database;

    try {
      await db.delete(
        currentUserTable.table,
      );

      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<BiaSQLiteModel>> createBia(BiaSQLiteModel bia) async {
    final db = await database;

    try {
      var resultUserId = await _getCurrentUserId();
      late int userId;
      switch (resultUserId) {
        case Ok():
          {
            userId = resultUserId.value;
          }
        case Error():
          {
            return Result.error(Exception("No current user"));
          }
      }

      bia.id = await db.insert(
        biaTable.table,
        {
          biaTable.userId: userId,
          biaTable.timestamp: bia.timestamp,
          biaTable.weight: bia.weight,
          biaTable.muscleMass: bia.muscleMass,
          biaTable.fatMass: bia.fatMass,
          biaTable.waterMass: bia.waterMass,
        },
      );

      return Result.ok(bia);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<BiaSQLiteModel>> getBia(int id) async {
    final db = await database;

    try {
      var result = await db.query(
        biaTable.table,
        columns: [
          biaTable.id,
          biaTable.userId,
          biaTable.timestamp,
          biaTable.weight,
          biaTable.muscleMass,
          biaTable.fatMass,
          biaTable.waterMass,
        ],
      );

      BiaSQLiteModel bia = BiaSQLiteModel.fromMap(result.singleOrNull!);
      return Result.ok(bia);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<List<BiaSQLiteModel>>> getBias() async {
    final db = await database;

    try {
      var resultUserId = await _getCurrentUserId();
      late int userId;
      switch (resultUserId) {
        case Ok():
          {
            userId = resultUserId.value;
          }
        case Error():
          {
            return Result.error(Exception("No current user"));
          }
      }

      var result = await db.query(
        biaTable.table,
        columns: [
          biaTable.id,
          biaTable.userId,
          biaTable.timestamp,
          biaTable.weight,
          biaTable.muscleMass,
          biaTable.fatMass,
          biaTable.waterMass,
        ],
        where: "${biaTable.userId} = ?",
        whereArgs: [userId],
        orderBy: "${biaTable.timestamp} DESC",
      );

      List<BiaSQLiteModel> bias = [];
      for (var b in result) {
        BiaSQLiteModel bia = BiaSQLiteModel.fromMap(b);
        bias.add(bia);
      }

      return Result.ok(bias);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> deleteBia(int id) async {
    final db = await database;

    try {
      await db.delete(
        biaTable.table,
        where: "${biaTable.id} = ?",
        whereArgs: [id],
      );

      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  /* ------------------------------------- */
}
