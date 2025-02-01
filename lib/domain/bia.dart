import 'package:flutter_app_test/data/services/tables.dart';

class Bia {
    int? id;
    int? userId;
    DateTime timestamp;
    double weight;
    double muscleMass;
    double fatMass;
    double waterMass;

    double get bodyFatRatio => fatMass / weight;

    Bia({
        this.id,
        this.userId,
        required this.timestamp,
        required this.weight,
        required this.muscleMass,
        required this.fatMass,
        required this.waterMass,
    });

    factory Bia.fromMap(Map<String, Object?> map) {
        return Bia(
            id: map[biaTable.id] as int?,
            userId: map[biaTable.userId] as int?,
            timestamp: map[biaTable.timestamp] as DateTime,
            weight: map[biaTable.weight] as double,
            muscleMass: map[biaTable.muscleMass] as double,
            fatMass: map[biaTable.fatMass] as double,
            waterMass: map[biaTable.waterMass] as double,
        );
    }
}
