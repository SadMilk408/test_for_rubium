import 'package:flutter/material.dart';
import 'package:test_for_rubium/presentation/bloc/all_users_bloc/all_users_bloc.dart';
import 'package:test_for_rubium/presentation/pages/all_users/all_users.dart';
import 'package:test_for_rubium/presentation/pages/authorization/auth.dart';

import 'core/dictionaries/constants.dart';
import 'core/dictionaries/routes.dart';
import 'core/singletons/local_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      initialRoute: LocalStorage.getString(AppConstants.LOGIN).isEmpty ? AppRoutes.auth : AppRoutes.allUsers,
      // initialRoute: AppRoutes.auth,
      routes: {
        AppRoutes.auth: (context) => AuthPage(),
        AppRoutes.allUsers: (context) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AllUsersBloc()..add(AllUsersLoadingEvent(page: 1, results: 20)),
            ),
          ],
          child: AllUsers(),
        ),
        // AppRoutes.userInfo: (context) => UserInfoPage(),
        // AppRoutes.favorites: (context) => FavoritesPage(),
      },
    );
  }
}