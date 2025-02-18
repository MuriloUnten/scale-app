// import 'package:flutter/material.dart';
// import 'package:flutter_command/flutter_command.dart';
// import 'package:go_router/go_router.dart';
// import 'package:scale_app/ui/bluetooth/bluetooth_viewmodel.dart';
//
// class BleReadTestScreen extends StatefulWidget {
//     const BleReadTestScreen  ({
//         super.key,
//         required this.viewModel,
//     });
//
//     final BluetoothViewmodel viewModel;
//
//     @override
//     State<BleReadTestScreen > createState() => _BleReadTestScreen();
// }
//
// class _BleReadTestScreen extends State<BleReadTestScreen > {
//
//     @override
//     void initState() {
//         super.initState();
//     }
//
//     @override
//     build(BuildContext context) {
//         return Scaffold(
//             appBar: AppBar(
//                 leading: BackButton(onPressed: () => context.goNamed("home")),
//                 title: Text("Bluetooth read test"),
//                 centerTitle: true,
//             ),
//             body: Center(
//                 child: Column(
//                     children: [
//                         MaterialButton(
//                             onPressed: () {
//                                 widget.viewModel.measureCommand.execute();
//                             },
//                             child: Text("read"),
//                         ),
//                         CommandBuilder(
//                             command: widget.viewModel.measureCommand,
//                             whileExecuting: (context, _, __) {
//                                 return Column(
//                                     children: [
//                                         Text("Measurement in progress. Hang tight!"),
//                                          SizedBox (
//                                             width: 50.0,
//                                             height: 50.0,
//                                             child: CircularProgressIndicator(),
//                                         ),
//                                     ],
//                                 );
//                             },
//                             onError: (context, _, __, ___) {
//                                 return Text("Measurement Failed");
//                             },
//                             onData: (context, result, _) {
//                                 return Column(
//                                     children: [
//                                         Text("Weight: ${result["m"]}"),
//                                         Text("Impedance: ${result["Z"]}"),
//                                     ],
//                                 );
//                             },
//                         ),
//                     ],
//                 ),
//             ),
//         );
//     }
// }
