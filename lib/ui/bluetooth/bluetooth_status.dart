import 'package:flutter_command/flutter_command.dart';
import 'package:scale_app/ui/bluetooth/bluetooth_viewmodel.dart';
import 'package:flutter/material.dart';

class BluetoothStatus extends StatefulWidget implements PreferredSizeWidget {
    const BluetoothStatus({
        super.key,
        required this.viewModel,
    });

    final BluetoothViewmodel viewModel;
    
    @override
    State<BluetoothStatus> createState() => _BluetoothStatusState();

  @override
  Size get preferredSize => Size.fromHeight(25);
}


class _BluetoothStatusState extends State<BluetoothStatus> {
    @override
    void initState() {
        super.initState();
    }
    
    @override
    Widget build(BuildContext context) {
        return CommandBuilder(
            command: widget.viewModel.getStatusConnected,
            onData: (context, connected, _) {
                if (widget.viewModel.connected) {
                    return PreferredSize(
                        preferredSize: widget.preferredSize,
                        child: Card(
                            color: Theme.of(context).colorScheme.surfaceContainerLow,
                            shape: LinearBorder(),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Icon(Icons.bluetooth_connected),
                                    SizedBox(width: 8),
                                    Text(widget.viewModel.deviceName != "" ? "Connected to ${widget.viewModel.deviceName}" : "Connected"),
                                ],
                            ),
                        ),
                    );
                } else {
                    return PreferredSize(
                        preferredSize: widget.preferredSize,
                        child: Card(
                            color: Theme.of(context).colorScheme.surfaceContainerLow,
                            shape: LinearBorder(),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                    Icon(Icons.bluetooth_disabled),
                                    SizedBox(width: 8),
                                    Text("Not connected"),
                                ],
                            ),
                        ),
                    );
                }
            }
        );
    }
}
