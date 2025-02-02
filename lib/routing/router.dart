import "package:flutter_app_test/data/repositories/user_repository.dart";
import "package:flutter_app_test/ui/home/home_screen.dart";
import "package:flutter_app_test/ui/home/home_viewmodel.dart";
import "package:flutter_app_test/ui/user/create_user_screen.dart";
import "package:flutter_app_test/ui/user/create_user_viewmodel.dart";
import "package:flutter_app_test/utils/result.dart";

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
                final viewmodel = HomeViewmodel(
                    userRepository: context.read(),
                    biaRepository: context.read(),
                );
                return HomeScreen(viewModel: viewmodel);
            },
        ),
        GoRoute(
            name: "createUser",
            path: "/create-user",
            builder: (context, state) {
                final viewModel = CreateUserViewmodel(userRepository: context.read());
                return CreateUser(viewModel: viewModel);
            }
        )

    ],
    redirect: (context, state) async {
        final loggedIn = await context.read<UserRepository>().getCurrentUser();
        if (loggedIn is Error) {
            return "/create-user";
        }

        final loggingIn = state.matchedLocation == "/create-user";
        if (loggingIn) {
            return "/";
        }

        return null;
    }
);
