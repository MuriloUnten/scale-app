import 'package:flutter_app_test/domain/bia.dart';
import 'package:flutter_app_test/ui/home/home_viewmodel.dart';
import 'package:flutter_app_test/utils/result.dart';
import "package:flutter_app_test/ui/bias/bias_list.dart";

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
            appBar: AppBar(
                title: Text(
                    "Home",
                    style: Theme.of(context).textTheme.titleLarge,
                ),
                centerTitle: true,
                actions: [
                    IconButton(
                        onPressed: () => context.goNamed("user"),
                        icon: Icon(Icons.account_circle)
                    ),
                ],
            ),
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
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 10,
                            children: [
                                Container(
                                    padding: EdgeInsets.only(left: 35),
                                    child: Text(
                                        "Hello, ${widget.viewModel.user!.firstName}!",
                                        style: Theme.of(context).textTheme.titleLarge,
                                        textAlign: TextAlign.left,
                                    ),
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 35),
                                    child: Text(
                                        "Last Measurements",
                                        style: Theme.of(context).textTheme.headlineMedium,
                                        textAlign: TextAlign.left,
                                    ),
                                ),
                                BiasList(bias: widget.viewModel.recentBias),
                            ],
                        );
                    },
                ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.all(Radius.circular(20)),
                ),
                onPressed: () => context.goNamed("createBia"),
                icon: Icon(Icons.add),
                label: Text("Measure"),
                elevation: 10,
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
