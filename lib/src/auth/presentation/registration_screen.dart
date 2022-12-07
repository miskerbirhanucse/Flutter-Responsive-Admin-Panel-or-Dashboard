import 'package:admin/utils/utils.dart';
import 'package:flutter/material.dart';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sms_mobile/src/auth/presentation/login_screen.dart';
// import 'package:sms_mobile/src/home/presentation/home_screen.dart';
//
// import '../../../utils/app_size.dart';
// import '../../../utils/button.dart';
// import '../../../utils/custom_textfield.dart';
// import '../../../utils/style_contants.dart';
// import '../bloc/auth.dart';

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

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
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
                      "Milto SMS ",
                      style: textHeader1,
                    ),
                    gapH16,
                    Text(
                      "Register",
                      style: textHeader3.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
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
                      child: Button(
                        text: 'Sign Up',
                        onPressed: () async {
                          //   final authBloc = BlocProvider.of<AuthCubit>(context);
                          //   await authBloc.register(
                          //       email: emailController.text,
                          //       password: passwordController.text);
                          //   authBloc.state.maybeWhen(
                          //     orElse: () {},
                          //     signedInUser: (_) {
                          //       Navigator.pushReplacementNamed(
                          //         context,
                          //         HomeScreen.routeName,
                          //       );
                          //     },
                          //   );
                        },
                      ),
                    ),
                    gapH12,
                    TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, LoginScreen.routeName);
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
    );
  }
}
