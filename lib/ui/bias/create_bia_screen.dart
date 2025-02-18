import 'package:flutter/material.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:scale_app/ui/bias/bia_card.dart';
import 'package:scale_app/ui/bias/create_bia_viewmodel.dart';
import 'package:scale_app/ui/bluetooth/bluetooth_status.dart';
import 'package:scale_app/ui/bluetooth/bluetooth_viewmodel.dart';

class CreateBiaScreen extends StatefulWidget {
    const CreateBiaScreen  ({
        super.key,
        required this.viewModel,
    });

    final CreateBiaViewmodel viewModel;

    @override
    State<CreateBiaScreen > createState() => _CreateBiaScreen();
}

class _CreateBiaScreen extends State<CreateBiaScreen > {

    @override
    void initState() {
        super.initState();
    }

    @override
    build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                leading: BackButton(onPressed: () => context.goNamed("home")),
                title: Text("Measure"),
                centerTitle: true,
                bottom: BluetoothStatus(viewModel: BluetoothViewmodel(bleRepository: context.read())),
            ),
            body: Center(
                child: Column(
                    children: [
                        MaterialButton(
                            onPressed: () => widget.viewModel.measureCommand.execute(),
                            child: Text("read"),
                        ),
                        CommandBuilder(
                            command: widget.viewModel.measureCommand,
                            whileExecuting: (context, _, __) {
                                return Column(
                                    children: [
                                        Text("Measurement in progress. Hang tight!"),
                                         SizedBox (
                                            width: 50.0,
                                            height: 50.0,
                                            child: CircularProgressIndicator(),
                                        ),
                                    ],
                                );
                            },
                            onError: (context, _, __, ___) {
                                return Text("Measurement Failed");
                            },
                            onData: (context, result, _) {
                                return Center(
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            BiaCard(bia: widget.viewModel.bia!, detailed: true),
                                            MaterialButton(
                                                onPressed: () => widget.viewModel.saveBiaCommand.execute(),
                                            ),
                                        ],
                                    ),
                                );
                            },
                        ),
                    ],
                ),
            ),
        );
    }
}
