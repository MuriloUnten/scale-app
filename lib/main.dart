import 'package:flutter_command/flutter_command.dart';
import 'package:scale_app/config/dependencies.dart';
import 'package:scale_app/routing/router.dart';

import 'package:flutter/material.dart';
import "package:provider/provider.dart";
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
    if (Platform.isWindows) {
      print("Why are You still using Windows?");
    }

    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  FlutterBluePlus.setLogLevel(LogLevel.verbose);
  if (await FlutterBluePlus.isSupported == false) {
    print("Bluetooth not supported by this device");
    return;
  }

  Command.globalExceptionHandler = (commandError, stackTrace) {
    print("__________________________________________");
    print("ERROR");
    print(
        "Command ${commandError.commandName} failed with error ${commandError.error.toString()}");
    print("STACKTRACE");
    print(stackTrace.toString());
    print("__________________________________________");
  };

  Command.loggingHandler = (commandName, result) {
    print("EXECUTING COMMAND: $commandName");
  };

  runApp(
    MultiProvider(
      providers: providers,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: ThemeMode.dark,
      routerConfig: router(),
    );
  }
}
