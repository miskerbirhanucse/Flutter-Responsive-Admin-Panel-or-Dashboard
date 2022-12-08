import 'package:admin/src/auth/presentation/login_screen.dart';
import 'package:admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth.dart';

class RegistrationScreen extends StatefulWidget {
  static const String routeName = '/signup-screen';

  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  var isLoading = false;

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
          authenticated: (_) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                gapH64,
                Container(
                  height: height * 0.8,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      gapH16,
                      Text(
                        "Register",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      gapH24,
                      Center(
                        child: CustomTextField(
                          controller: nameController,
                          title: 'Enter your name',
                        ),
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
                          controller: phoneController,
                          title: 'Enter your phone address',
                        ),
                      ),
                      gapH24,
                      Center(
                        child: CustomTextField(
                          controller: passwordController,
                          title: 'Enter your password address',
                          obscureText: true,
                        ),
                      ),
                      gapH32,
                      Center(
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Button(
                                text: 'Sign Up',
                                onPressed: () async {
                                  final authBloc =
                                      BlocProvider.of<AuthCubit>(context);
                                  await authBloc.register(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                    phone: phoneController.text,
                                  );
                                },
                              ),
                      ),
                      gapH12,
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "already have an account?",
                          style: textHeader3.copyWith(),
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
