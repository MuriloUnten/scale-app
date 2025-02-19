import "package:scale_app/data/repositories/user_repository.dart";
import "package:scale_app/ui/bias/create_bia_screen.dart";
import "package:scale_app/ui/bias/create_bia_viewmodel.dart";
import "package:scale_app/ui/bluetooth/bluetooth_devices_screen.dart";
import "package:scale_app/ui/bluetooth/bluetooth_viewmodel.dart";
import "package:scale_app/ui/home/home_screen.dart";
import "package:scale_app/ui/home/home_viewmodel.dart";
import "package:scale_app/ui/user/create_user_screen.dart";
import "package:scale_app/ui/user/create_user_viewmodel.dart";
import "package:scale_app/ui/user/select_user_screen.dart";
import "package:scale_app/ui/user/select_user_viewmodel.dart";
import "package:scale_app/ui/user/user_profile_screen.dart";
import "package:scale_app/ui/user/user_profile_viewmodel.dart";
import "package:scale_app/utils/result.dart";

import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GoRouter router() => GoRouter(
    initialLocation: "/",
    debugLogDiagnostics: true,
    navigatorKey: navigatorKey,
    routes: [
        GoRoute(
            name: "home",
            path: "/",
            builder: (context, state) {
                final viewmodel = HomeViewmodel(
                    userRepository: context.read(),
                    biaRepository: context.read(),
                    bleRepository: context.read(),
                );
                return HomeScreen(viewModel: viewmodel);
            },
        ),
        GoRoute(
            name: "createUser",
            path: "/create-user",
            builder: (context, state) {
                final viewModel = CreateUserViewmodel(userRepository: context.read());
                return CreateUserScreen(viewModel: viewModel);
            }
        ),
        GoRoute(
            name: "selectUser",
            path: "/select-user",
            builder: (context, state) {
                final viewModel = SelectUserViewmodel(userRepository: context.read());
                return SelectUserScreen(viewModel: viewModel);
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
        GoRoute(
            name: "measure",
            path: "/measure",
            builder: (context, state) {
                final viewModel = CreateBiaViewmodel(
                    bleRepository: context.read(),
                    biaRepository: context.read(),
                    userRepository: context.read(),
                );
                return CreateBiaScreen(viewModel: viewModel);
            },
        ),
        GoRoute(
            name: "devices",
            path: "/devices",
            builder: (context, state) {
                final viewModel = BluetoothViewmodel(bleRepository: context.read());
                return BluetoothDevicesScreen(viewModel: viewModel);
            },
        ),
    ],
    redirect: (context, state) async {
        final loggingIn = state.matchedLocation == "/create-user" || state.matchedLocation == "/select-user";
        if (loggingIn) {
            return null;
        }

        final loggedIn = await context.read<UserRepository>().getCurrentUser();
        if (loggedIn is Error) {
            return "/select-user";
        }

        return null;
    }
);
