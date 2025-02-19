import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:go_router/go_router.dart';
import 'package:scale_app/ui/bluetooth/bluetooth_viewmodel.dart';

class BluetoothDevicesScreen extends StatefulWidget {
    const BluetoothDevicesScreen ({
        super.key,
        required this.viewModel,
    });

    final BluetoothViewmodel viewModel;

    @override
    State<BluetoothDevicesScreen> createState() => _BluetoothDevicesScreen();
}

class _BluetoothDevicesScreen extends State<BluetoothDevicesScreen> {
    @override
    void initState() {
        super.initState();
    }


    @override
    build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                leading: BackButton(onPressed: () => context.pop(true)),
                title: Text("Bluetooth Devices"),
                centerTitle: true,
            ),
            body: Center(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                            Text(
                                "Select the correct device to connect to",
                                style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SizedBox(height: 15),
                            Expanded(
                                child: CommandBuilder<void, List<ScanResult>> (
                                    command: widget.viewModel.scanCommand..execute(),
                                    whileExecuting: (context, _, __) => Center(
                                        child: SizedBox (
                                            width: 50.0,
                                            height: 50.0,
                                            child: CircularProgressIndicator(),
                                        ),
                                    ),
                                    onError: (context, _, __, ___) => Center(
                                        child: Text("Failed to load devices"),
                                    ),
                                    onData: (context, devices, _) {
                                        return ListView.builder(
                                            itemCount: devices.length,
                                            itemBuilder: (context, idx) {
                                                return Padding(
                                                    padding: EdgeInsets.symmetric(vertical: 5),
                                                    child: MaterialButton(
                                                        color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                                                        padding: EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 20,
                                                        ),
                                                        onPressed: () {
                                                            widget.viewModel.connectCommand(devices[idx].device);
                                                            context.goNamed("measure");
                                                        },
                                                        child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                                Text(
                                                                    devices[idx].device.advName != "" ? devices[idx].device.advName : "No name",
                                                                    style: Theme.of(context).textTheme.titleLarge,
                                                                ),
                                                                SizedBox(height: 10),
                                                                Text("ID: ${devices[idx].device.remoteId}"),
                                                            ],
                                                        ),
                                                    ),
                                                    
                                                );
                                            },
                                        );
                                    },
                                ),
                            ),
                        ],
                    ),
                ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                icon: Icon(Icons.search),
                label: Text("Scan"),
                onPressed: () => widget.viewModel.scanCommand.execute(),
            ),
        );
    }
}
