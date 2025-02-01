import 'package:flutter_app_test/ui/home/home_viewmodel.dart';
import 'package:flutter_app_test/utils/result.dart';

import 'package:flutter_command/flutter_command.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
    const HomeScreen({
        super.key,
        required this.viewModel,
    });

    final HomeViewmodel viewModel;

    @override
    State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    @override
    void initState() {
        super.initState();
    }

    @override
    void didUpdateWidget(covariant HomeScreen oldWidget) {
        super.didUpdateWidget(oldWidget);
    }

    @override
    void dispose() {
        super.dispose();
    }

    @override
    build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
                top: true,
                bottom: true,
                child: CommandBuilder<void, Result<void>>(
                    command: widget.viewModel.load,
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
                        if (data is Error) {
                            // return context.namedLocation("createUser");
                            return Column(
                                children: [
                                    const Text("Redirect to user creation"),
                                ],
                            );
                        }
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 15,
                            children: [
                                Container(
                                    padding: EdgeInsets.only(left: 35),
                                    child: Text(
                                        "Last Measurements",
                                        style: Theme.of(context).textTheme.headlineLarge,
                                        textAlign: TextAlign.left,
                                    ),
                                ),
                                Center(
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        spacing: 8,
                                        children: [
                                            Card(
                                                elevation: 10,
                                                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                                child: Container(
                                                    width: 400,
                                                    height: 140,
                                                    padding: EdgeInsets.all(15),
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 12,
                                                        children: [
                                                            Row(
                                                                spacing: 10,
                                                                children: [
                                                                    Icon(
                                                                        Icons.calendar_today,
                                                                    ),
                                                                    Text(
                                                                        "29/01/2025",
                                                                        style: Theme.of(context).textTheme.titleLarge,
                                                                    ),
                                                                ],
                                                            ),
                                                            Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                spacing: 60,
                                                                children: [
                                                                    Container(
                                                                        padding: EdgeInsets.only(left: 35),
                                                                        child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                                Text(
                                                                                    "Weight",
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors.grey,
                                                                                        fontWeight: FontWeight.w400,
                                                                                    )
                                                                                ),
                                                                                Text(
                                                                                    "70.4 Kg",
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Theme.of(context).colorScheme.onSurface,
                                                                                        fontWeight: FontWeight.w600,
                                                                                    )
                                                                                )
                                                                            ],
                                                                        ),
                                                                    ),
                                                                    Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                            Text(
                                                                                "Body fat",
                                                                                style: TextStyle(
                                                                                    fontSize: 20,
                                                                                    color: Colors.grey,
                                                                                    fontWeight: FontWeight.w400,
                                                                                )
                                                                            ),
                                                                            Text(
                                                                                "15%",
                                                                                style: TextStyle(
                                                                                    fontSize: 20,
                                                                                    color: Theme.of(context).colorScheme.onSurface,
                                                                                    fontWeight: FontWeight.w600,
                                                                                )
                                                                            )
                                                                        ],
                                                                    ),
                                                                ],
                                                            ),
                                                        ],
                                                    ),
                                                ),
                                            ),
                                            Card(
                                                elevation: 10,
                                                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                                child: Container(
                                                    width: 400,
                                                    height: 140,
                                                    padding: EdgeInsets.all(15),
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 12,
                                                        children: [
                                                            Row(
                                                                spacing: 10,
                                                                children: [
                                                                    Icon(
                                                                        Icons.calendar_today,
                                                                    ),
                                                                    Text(
                                                                        "01/01/2025",
                                                                        style: Theme.of(context).textTheme.titleLarge,
                                                                    ),
                                                                ],
                                                            ),
                                                            Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                spacing: 60,
                                                                children: [
                                                                    Container(
                                                                        padding: EdgeInsets.only(left: 35),
                                                                        child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                                Text(
                                                                                    "Weight",
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors.grey,
                                                                                        fontWeight: FontWeight.w400,
                                                                                    )
                                                                                ),
                                                                                Text(
                                                                                    "72.2 Kg",
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Theme.of(context).colorScheme.onSurface,
                                                                                        fontWeight: FontWeight.w600,
                                                                                    )
                                                                                )
                                                                            ],
                                                                        ),
                                                                    ),
                                                                    Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                            Text(
                                                                                "Body fat",
                                                                                style: TextStyle(
                                                                                    fontSize: 20,
                                                                                    color: Colors.grey,
                                                                                    fontWeight: FontWeight.w400,
                                                                                )
                                                                            ),
                                                                            Text(
                                                                                "17%",
                                                                                style: TextStyle(
                                                                                    fontSize: 20,
                                                                                    color: Theme.of(context).colorScheme.onSurface,
                                                                                    fontWeight: FontWeight.w600,
                                                                                )
                                                                            )
                                                                        ],
                                                                    ),
                                                                ],
                                                            ),
                                                        ],
                                                    ),
                                                ),
                                            ),
                                            Card(
                                                elevation: 10,
                                                color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                                child: Container(
                                                    width: 400,
                                                    height: 140,
                                                    padding: EdgeInsets.all(15),
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        spacing: 12,
                                                        children: [
                                                            Row(
                                                                spacing: 10,
                                                                children: [
                                                                    Icon(
                                                                        Icons.calendar_today,
                                                                    ),
                                                                    Text(
                                                                        "02/12/2024",
                                                                        style: Theme.of(context).textTheme.titleLarge,
                                                                    ),
                                                                ],
                                                            ),
                                                            Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                spacing: 60,
                                                                children: [
                                                                    Container(
                                                                        padding: EdgeInsets.only(left: 35),
                                                                        child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                                Text(
                                                                                    "Weight",
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Colors.grey,
                                                                                        fontWeight: FontWeight.w400,
                                                                                    )
                                                                                ),
                                                                                Text(
                                                                                    "75.6 Kg",
                                                                                    style: TextStyle(
                                                                                        fontSize: 20,
                                                                                        color: Theme.of(context).colorScheme.onSurface,
                                                                                        fontWeight: FontWeight.w600,
                                                                                    )
                                                                                )
                                                                            ],
                                                                        ),
                                                                    ),
                                                                    Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                            Text(
                                                                                "Body fat",
                                                                                style: TextStyle(
                                                                                    fontSize: 20,
                                                                                    color: Colors.grey,
                                                                                    fontWeight: FontWeight.w400,
                                                                                )
                                                                            ),
                                                                            Text(
                                                                                "19%",
                                                                                style: TextStyle(
                                                                                    fontSize: 20,
                                                                                    color: Theme.of(context).colorScheme.onSurface,
                                                                                    fontWeight: FontWeight.w600,
                                                                                )
                                                                            )
                                                                        ],
                                                                    ),
                                                                ],
                                                            ),
                                                        ],
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                )
                            ],
                        );
                    },
                ),
            ),
            bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.history),
                        label: 'History',
                    ),
                ],
            ),
        );
    }
}
