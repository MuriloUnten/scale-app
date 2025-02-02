import "package:scale_app/data/repositories/user_repository.dart";
import "package:scale_app/ui/home/home_screen.dart";
import "package:scale_app/ui/home/home_viewmodel.dart";
import "package:scale_app/ui/user/create_user_screen.dart";
import "package:scale_app/ui/user/create_user_viewmodel.dart";
import "package:scale_app/ui/user/user_profile_screen.dart";
import "package:scale_app/ui/user/user_profile_viewmodel.dart";
import "package:scale_app/utils/result.dart";

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
        ),
        GoRoute(
            name: "user",
            path: "/user",
            builder: (context, state) {
                final viewModel = UserProfileViewmodel(userRepository: context.read());
                return UserProfileScreen(viewModel: viewModel);
            },
        ),

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
