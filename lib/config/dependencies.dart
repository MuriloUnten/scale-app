import "package:provider/provider.dart";
import "package:provider/single_child_widget.dart";
import "package:scale_app/data/repositories/ble_repository.dart";
import "package:scale_app/data/services/ble_service.dart";

import "../data/services/sqlite_storage.dart";
import "../data/repositories/user_repository.dart";
import "../data/repositories/bia_repository.dart";

List<SingleChildWidget> get providers {
    return [
        Provider(
            create: (context) => SQLiteStorage.instance,
        ),
        Provider(
            create: (context) => BLEService(),
        ),
        Provider(
            create: (context) => BLERepository(
                bleService: context.read()
            ),
        ),
        Provider(
            create: (context) => UserRepository(
                storage: context.read()
            ),
        ),
        Provider(
            create: (context) => BiaRepository(
                storage: context.read()
            ),
        )
    ];
}
