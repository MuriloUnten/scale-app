import 'package:flutter_app_test/data/services/tables.dart';

class BiaSQLiteModel {
    int? id;
    int? userId;
    String timestamp;
    num weight;
    num muscleMass;
    num fatMass;
    num waterMass;

    BiaSQLiteModel({
        this.id,
        this.userId,
        required this.timestamp,
        required this.weight,
        required this.muscleMass,
        required this.fatMass,
        required this.waterMass,
    });

    factory BiaSQLiteModel.fromMap(Map<String, Object?> map) {
        return BiaSQLiteModel(
            id: map[biaTable.id] as int?,
            userId: map[biaTable.userId] as int?,
            timestamp: map[biaTable.timestamp] as String,
            weight: map[biaTable.weight] as num,
            muscleMass: map[biaTable.muscleMass] as num,
            fatMass: map[biaTable.fatMass] as num,
            waterMass: map[biaTable.waterMass] as num,
        );
    }
}
