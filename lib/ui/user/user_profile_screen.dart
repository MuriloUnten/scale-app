import 'package:scale_app/domain/sex.dart';
import 'package:scale_app/domain/user.dart';
import 'package:scale_app/ui/user/user_card.dart';
import 'package:scale_app/ui/user/user_profile_viewmodel.dart';

import 'package:flutter/material.dart';
import 'package:scale_app/utils/format.dart';
import 'package:scale_app/utils/result.dart';
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
            appBar: AppBar(
                leading: BackButton(
                    onPressed: () => context.goNamed("home"),
                ),
                title: Text(
                    "Profile",
                    style: Theme.of(context).textTheme.titleLarge,
                ),
                centerTitle: true,
            ),
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

                        return UserCard(user: widget.viewModel.user!);
                    },
                ),
            ),
            floatingActionButton: FloatingActionButton.extended(
                onPressed: () => context.goNamed("editUser"),
                shape: RoundedRectangleBorder(
                    borderRadius:BorderRadius.all(Radius.circular(20)),
                ),
                icon: Icon(Icons.edit),
                label: Text("Edit"),
            ),
        );
    }
}
