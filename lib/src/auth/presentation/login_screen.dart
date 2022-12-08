import 'package:admin/src/auth/presentation/registration_screen.dart';
import 'package:admin/src/main/main_screen.dart';
import 'package:admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = true;
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AuthCubit>(context).checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        state.maybeMap(
          orElse: () {},
          loading: (_) {
            setState(() {
              isLoading = true;
            });
          },
          signedInUser: (_) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
            );
          },
          authenticated: (_) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MainScreen(),
              ),
            );
          },
          unauthenticated: (_) {
            setState(() {
              isLoading = false;
            });
          },
          failure: (_) {
            setState(() {
              isLoading = false;
            });
          },
        );
      },
      child: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      gapH64,
                      gapH48,
                      Container(
                        height: height * 0.6,
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.black12),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            gapH48,
                            Text(
                              "Generator App",
                              // style: textHeader1,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            gapH16,
                            Text(
                              "Login",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            gapH24,
                            Center(
                              child: CustomTextField(
                                controller: emailController,
                                title: 'Enter your email address',
                              ),
                            ),
                            gapH24,
                            Center(
                              child: CustomTextField(
                                controller: passwordController,
                                title: 'Enter your password address',
                                obscureText: !showPassword,
                                showSuffixIcon: true,
                                isShowPassword: showPassword,
                                onPressedForPassword: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                              ),
                            ),
                            gapH32,
                            Center(
                              child: isLoading
                                  ? CircularProgressIndicator()
                                  : SizedBox(
                                      height: 60,
                                      width: 200,
                                      child: Button(
                                        text: 'Login',
                                        onPressed: () async {
                                          final authBloc =
                                              BlocProvider.of<AuthCubit>(
                                                  context);
                                          await authBloc.login(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          );
                                        },
                                      ),
                                    ),
                            ),
                            gapH12,
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => RegistrationScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                "sign up",
                                style: textHeader3.copyWith(
                                    color: CustomColor.primaryColor),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
