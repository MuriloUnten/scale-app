import 'package:flutter_app_test/domain/user.dart';
import 'package:flutter_app_test/ui/user/user_profile_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/utils/format.dart';
import 'package:flutter_app_test/utils/result.dart';
import 'package:flutter_command/flutter_command.dart';
import 'package:go_router/go_router.dart';

class UserProfileScreen extends StatefulWidget {
    const UserProfileScreen({
        super.key,
        required this.viewModel,
    });

    final UserProfileViewmodel viewModel;

    @override
    State<UserProfileScreen> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfileScreen> {
    @override
    void initState() {
        super.initState();
    }

    @override void didUpdateWidget(covariant oldWidget) {
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
                child: CommandBuilder<void, Result<User>>(
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
                            context.goNamed("createUser");
                        }

                        return Column(
                            children: [
                                Text(
                                    widget.viewModel.user!.fullName,
                                ),
                                Text(
                                    formatDate(widget.viewModel.user!.dateOfBirth),
                                ),
                                Text(
                                    "${widget.viewModel.user!.height} cm",
                                ),
                                Text(
                                    widget.viewModel.user!.height.toString(),
                                ),
                            ],
                        );
                    },
                ),
            ),
        );
    }
}
