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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                                        spacing: 12,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                            BiaCard(bia: widget.viewModel.bia!, detailed: true),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                spacing: 12,
                                                children: [
                                                    MaterialButton(
                                                        minWidth: 150,
                                                        height: 50,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                        color: Colors.red,
                                                        onPressed: () {
                                                            widget.viewModel.clearMeasurement();
                                                            return;
                                                        },
                                                        child: Row(
                                                            spacing: 10,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                                Icon(
                                                                    Icons.delete,
                                                                    size: 25,
                                                                ),
                                                                Text(
                                                                    "Delete",
                                                                    style: TextStyle(
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Colors.white,
                                                                    )
                                                                ),
                                                            ],
                                                        )
                                                    ),
                                                    MaterialButton(
                                                        minWidth: 150,
                                                        height: 50,
                                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                                        color: Colors.green,
                                                        onPressed: () async{
                                                            widget.viewModel.saveBiaCommand.execute();
                                                            context.goNamed("home");
                                                        },
                                                        child: Row(
                                                            spacing: 10,
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                                Icon(
                                                                    Icons.save,
                                                                    size: 25,
                                                                ),
                                                                Text(
                                                                    "Save",
                                                                    style: TextStyle(
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.w500,
                                                                        color: Colors.white,
                                                                    )
                                                                ),
                                                            ],
                                                        )
                                                    ),
                                                    SizedBox(width: 8),
                                                ],
                                            )
                                        ],
                                    ),
                                );
                            },
                        ),
                    ],
                ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () => widget.viewModel.measureCommand.execute(),
                icon: Icon(Icons.graphic_eq),
                label: Text("Start Measurement"),
            ),
        );
    }
}
