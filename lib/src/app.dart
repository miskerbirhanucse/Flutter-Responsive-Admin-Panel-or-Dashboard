import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../controllers/MenuController.dart';
import '../network/api_client.dart';
import 'auth/bloc/auth.dart';
import 'auth/presentation/login_screen.dart';
import 'user/bloc/user_cubit.dart';
import 'user/bloc/user_detail_cubit.dart';
import 'user/presentation/create_user.dart';
import 'user/presentation/user_dashboard.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiClient = GetIt.I<ApiClient>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuController(),
        ),
        BlocProvider(
          create: (_) => AuthCubit(apiClient),
        ),
        BlocProvider(
          create: (_) => UserCubit(apiClient),
        ),
        BlocProvider(
          create: (_) => UserDetailCubit(apiClient),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Admin Panel',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        initialRoute: LoginScreen.id,
        routes: {
          LoginScreen.id: (context) => const LoginScreen(),
          CreateUser.id: (context) => CreateUser(
                args: ModalRoute.of(context)!.settings.arguments
                    as Map<String, dynamic>,
              ),
          UserDashboardScreen.id: (context) => const UserDashboardScreen()
        },
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuController(),
            ),
            BlocProvider(
              create: (_) => AuthCubit(apiClient),
            ),
            BlocProvider(
              create: (_) => UserCubit(apiClient),
            ),
          ],
        ),
      ),
    );
  }
}
