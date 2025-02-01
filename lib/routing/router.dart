import "package:flutter_app_test/ui/home/home_screen.dart";
import "package:flutter_app_test/ui/home/home_viewmodel.dart";
import "package:flutter_app_test/ui/user/create_user_screen.dart";

import "package:go_router/go_router.dart";
import 'package:provider/provider.dart';

GoRouter router() => GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    routes: [
        GoRoute(
            name: "home",
            path: "/",
            builder: (context, state) {
                final viewModel = HomeViewmodel(
                    userRepository: context.read(),
                    biaRepository: context.read(),
                );
                return HomeScreen(viewModel: viewModel);
            },
        ),
        GoRoute(
            name: "createUser",
            path: "/create-user",
            builder: (context, state) {
                return CreateUser();
            }
        )

    ],
);
