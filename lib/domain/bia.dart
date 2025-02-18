import 'dart:math';

import 'package:scale_app/data/services/tables.dart';
import 'package:scale_app/domain/sex.dart';
import 'package:scale_app/domain/user.dart';
import 'package:scale_app/utils/format.dart';

class Bia {
    int? id;
    int? userId;
    DateTime timestamp;
    double weight;
    double muscleMass;
    double fatMass;
    double waterMass;

    double get bodyFatRatio => fatMass / weight;
    int get bodyFatPercentage => (bodyFatRatio * 100).toInt();

    String get formattedWeight => weight.toStringAsFixed(1);
    String get formattedMuscleMass => muscleMass.toStringAsFixed(1);
    String get formattedFatMass => fatMass.toStringAsFixed(1);
    String get formattedWaterMass => waterMass.toStringAsFixed(1);
    String get formattedTimestamp => formatDate(timestamp);

    Bia({
        this.id,
        this.userId,
        required this.timestamp,
        required this.weight,
        required this.muscleMass,
        required this.fatMass,
        required this.waterMass,
    });

    factory Bia.fromMeasurement(User user, double weight, double impedance) {
        double waterMass = 6.69 + (0.34573 * (pow(user.height, 2) / impedance)) + (0.17065 * weight) - (0.11 * user.age) + (user.sex == Sex.M ? 2.66 : 0);
        double fatFreeMass = waterMass / 0.73;
        double fatMass = weight - fatFreeMass;

        return Bia(timestamp: DateTime.now(), weight: weight, fatMass: fatMass, waterMass: waterMass, muscleMass: fatFreeMass);
    }

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
