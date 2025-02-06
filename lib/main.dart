import 'package:scale_app/config/dependencies.dart';
import 'package:scale_app/ui/home/home_screen.dart';
import 'package:scale_app/routing/router.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:provider/provider.dart";
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:io';

void main() async {
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
            // localizationsDelegates: [
            //     GlobalWidgetsLocalizations.delegate,
            //     GlobalMaterialLocalizations.delegate,
            //     AppLocalizationDelegate(),
            // ],
            // scrollBehavior: AppCustomScrollBehavior(),
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
