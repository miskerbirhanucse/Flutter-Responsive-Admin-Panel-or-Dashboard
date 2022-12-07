import 'package:admin/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                        obscureText: true,
                      ),
                    ),
                    gapH32,
                    Center(
                      child: SizedBox(
                        height: 60,
                        width: 200,
                        child: Button(
                          text: 'Login',
                          onPressed: () async {
                            // final authBloc = BlocProvider.of<AuthCubit>(context);
                            // await authBloc.login(
                            //     email: emailController.text,
                            //     password: passwordController.text);
                            // authBloc.state.maybeWhen(
                            //   orElse: () {},
                            //   signedInUser: (_) {
                            //     Navigator.pushReplacementNamed(
                            //         context, HomeScreen.routeName);
                            //   },
                            // );
                          },
                        ),
                      ),
                    ),
                    gapH12,
                    TextButton(
                      onPressed: () {
                        // Navigator.pushNamed(
                        //     context, RegistrationScreen.routeName);
                      },
                      child: Text(
                        "sign up",
                        style:
                            textHeader3.copyWith(color: CustomColor.lightBlue),
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
