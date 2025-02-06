import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:go_router/go_router.dart';
import 'package:scale_app/data/services/ble_service.dart';
import 'package:scale_app/utils/result.dart';

class BLETest extends StatefulWidget {
    const BLETest({
        super.key,
        required this.bleService,
    });

    final BLEService bleService;

    @override
    State<BLETest> createState() => _BLETestState();
}

class _BLETestState extends State<BLETest> {
    @override
    void initState() {
        super.initState();
        widget.bleService.scanCommand.execute();
    }

    @override
    build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                leading: BackButton(onPressed: () => context.goNamed("home")),
                title: Text("Bluetooth test"),
                centerTitle: true,
            ),
            body: CommandBuilder<void, List<ScanResult>>(
                command: widget.bleService.scanCommand,
                whileExecuting: (context, _, __) => Center(
                    child: SizedBox (
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(),
                    ),
                ),
                onError: (context, error, _, __) => Column(
                    children: [
                        Text('An Error has occurred!'),
                        Text(error.toString()),
                    ],
                ),
                onData: (context, data, _) {
                    if (data.isEmpty) {
                        print("NO RESULTS");
                    }

                    return Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                                Text("body created"),
                                ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: data.length,
                                    itemBuilder: (context, idx) {
                                        return Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                                Text("Name: ${data[idx].device.platformName != "" ? data[idx].device.platformName : "no name"}"),
                                                SizedBox(width:30),
                                                Text("Id: ${data[idx].device.remoteId}"),
                                            ],
                                        );
                                    },
                                )
                            ],
                        ),
                    );
                },
            ),
        );
    }
}
