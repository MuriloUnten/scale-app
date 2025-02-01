import "package:flutter_app_test/domain/bia.dart";
import "package:flutter_app_test/data/services/models/bia_sqlite_model.dart";
import "package:flutter_app_test/data/services/tables.dart";
import "package:flutter_app_test/data/services/sqlite_storage.dart";
import "package:flutter_app_test/utils/result.dart";

class BiaRepository {
    BiaRepository({
        required SQLiteStorage storage,
    }) : _storage = storage;

    final SQLiteStorage _storage;

    Future<Result<Bia>> createBia(Bia bia) async {
        var result = await _storage.createBia(_biaToDataModel(bia));

        switch (result) {
            case Ok(): {
                return Result.ok(_dataModelToBia(result.value));
            }
            case Error(): {
                return Result.error(Exception("Failed to create Bia"));
            }
        }
    }

    Future<Result<Bia>> getBia(int id) async {
        var result = await _storage.getBia(id);

        switch (result) {
            case Ok(): {
                return Result.ok(_dataModelToBia(result.value));
            }
            case Error(): {
                return Result.error(Exception("Failed to fetch Bia with id = $id"));
            }
        }
    }

    Future<Result<List<Bia>>> getBias() async {
        var result = await _storage.getBias();

        switch (result) {
            case Ok(): {
                List<Bia> bias = [];
                for (var biaData in result.value) {
                    bias.add(_dataModelToBia(biaData));
                }

                return Result.ok(bias);
            }
            case Error(): {
                return Result.error(Exception("Failed to fetch Bias"));
            }
        }
    }

    Future<Result<void>> deleteBia(int id) async {
        var result = await _storage.deleteBia(id);

        switch (result) {
            case Ok(): {
                return Result.ok(null);
            }
            case Error(): {
                return Result.error(Exception("Failed to delete Bia with id = $id"));
            }
        }
    }

    Bia _dataModelToBia(BiaSQLiteModel biaData) {
        return Bia.fromMap({
            biaTable.id: biaData.id,
            biaTable.userId: biaData.userId,
            biaTable.timestamp: DateTime.parse(biaData.timestamp),
            biaTable.weight: biaData.weight.toDouble(),
            biaTable.muscleMass: biaData.muscleMass.toDouble(),
            biaTable.fatMass: biaData.fatMass.toDouble(),
            biaTable.waterMass: biaData.waterMass.toDouble(),
        });
    }

    BiaSQLiteModel _biaToDataModel(Bia bia) {
        return BiaSQLiteModel.fromMap({
            biaTable.id: bia.id,
            biaTable.userId: bia.userId,
            biaTable.timestamp: bia.timestamp.toString(),
            biaTable.weight: bia.weight,
            biaTable.muscleMass:bia.muscleMass,
            biaTable.fatMass: bia.fatMass,
            biaTable.waterMass: bia.waterMass,
        });
    }
}
