import 'package:flutter_command/flutter_command.dart';
import 'package:go_router/go_router.dart';
import 'package:scale_app/ui/user/select_user_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:scale_app/utils/result.dart';

class SelectUserScreen extends StatefulWidget {
    const SelectUserScreen({
        super.key,
        required this.viewModel,
    });

    final SelectUserViewmodel viewModel;

    @override
    State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
    @override
    initState() {
       super.initState();
    }

    @override
    void didUpdateWidget(covariant SelectUserScreen oldWidget) {
        super.didUpdateWidget(oldWidget);
    }

    @override
    void dispose() {
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text(
                    "Select User",
                    style: Theme.of(context).textTheme.titleLarge,
                )
            ),
            body: CommandBuilder(
                command: widget.viewModel.getUsers,
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
                    switch (data) {
                        case Error(): {
                            // Sorry I know this is bad and I don't care
                            context.goNamed("createUser");
                        }
                        case Ok(): {
                            if (widget.viewModel.users.isEmpty) {
                                context.goNamed("createUser");
                            }
                        }
                    }

                    return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                Text(
                                    "Welcome back! Choose your user",
                                    style: Theme.of(context).textTheme.headlineMedium,
                                ),
                                SizedBox(height: 20),
                                ListView.builder(
                                    itemCount: widget.viewModel.users.length,
                                    shrinkWrap: true,
                                    itemBuilder: (context, idx) {
                                        return Column(
                                            children: [
                                                Card(
                                                    elevation: 10,
                                                    color: Theme.of(context).colorScheme.surfaceContainerLowest,
                                                    child: InkWell(
                                                        onTap: () async {
                                                            widget.viewModel.chooseUser(widget.viewModel.users[idx].id);
                                                            widget.viewModel.chooseUser.listen((result, _) {
                                                                switch (result) {
                                                                    case Ok(): {
                                                                        context.goNamed("home");
                                                                    }
                                                                    case Error(): {
                                                                        ScaffoldMessenger.of(context).showSnackBar(
                                                                            SnackBar(content: Text('Failed to select user. Error: ${result.error}')),
                                                                        );
                                                                    }
                                                                }
                                                            });
                                                        },
                                                        child: Padding(
                                                            padding: EdgeInsets.all(15),
                                                            child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                    Icon(
                                                                        Icons.account_circle,
                                                                        color: Theme.of(context).colorScheme.onSurface,
                                                                        size: 40,
                                                                    ),
                                                                    SizedBox(width: 15),
                                                                    Text(
                                                                        widget.viewModel.users[idx].fullName,
                                                                        style: TextStyle(
                                                                            color: Theme.of(context).colorScheme.onSurface,
                                                                            fontSize: 24,
                                                                            fontWeight: FontWeight.w600,
                                                                        ),
                                                                    ),
                                                                ],
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                                SizedBox(height: 10),
                                            ],
                                        );
                                    },
                                ),
                            ],
                        ),
                    );
                }
            ),
        );
    }
}
