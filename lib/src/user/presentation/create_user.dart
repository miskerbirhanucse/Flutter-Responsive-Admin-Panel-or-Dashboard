import 'package:admin/src/auth/bloc/auth.dart';
import 'package:admin/src/user/bloc/user_detail_cubit.dart';
import 'package:admin/src/user/bloc/user_detail_state.dart';
import 'package:admin/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CreateUser extends StatefulWidget {
  final String title;
  final String buttonText;
  final bool isEdit;
  final bool? status;

  const CreateUser({
    Key? key,
    required this.title,
    required this.buttonText,
    this.isEdit = false,
    this.status,
  }) : super(key: key);

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  bool showPassword = false;
  bool? changeStatus;
  int? userId;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userDetailCubit = BlocProvider.of<UserDetailCubit>(context);
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
            setState(() {
              isLoading = false;
              nameController.clear();
              phoneController.clear();
              emailController.clear();
            });
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10,
          ),
          child: SingleChildScrollView(
            child: Center(
              child: BlocBuilder<UserDetailCubit, UserDetailState>(
                  builder: (context, state) {
                return state.maybeMap(
                  orElse: () {
                    return Container();
                  },
                  data: (_) {
                    changeStatus = _.user.status;
                    userId = _.user.id;

                    emailController.text = _.user.email!;
                    nameController.text = _.user.name!;
                    phoneController.text = _.user.phone ?? '';
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        gapH24,
                        CustomTextField(
                          controller: nameController,
                          title: 'Enter name',
                        ),
                        gapH24,
                        CustomTextField(
                          controller: emailController,
                          title: 'Enter email address',
                        ),
                        gapH24,
                        CustomTextField(
                          controller: phoneController,
                          title: 'Enter phone number',
                        ),
                        if (widget.isEdit)
                          Column(
                            children: [
                              gapH24,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Change user status",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "Enable or disable to change \na user status",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                color: Colors.white60,
                                              ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15.0),
                                    child: FlutterSwitch(
                                      value: changeStatus ?? false,
                                      onToggle: (value) {
                                        userDetailCubit.changeUserStatus(
                                          id: userId!,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        gapH32,
                        Center(
                          child: isLoading
                              ? CircularProgressIndicator()
                              : Button(
                                  text: widget.buttonText,
                                  onPressed: () async {
                                    if (widget.isEdit) {
                                      await BlocProvider.of<UserDetailCubit>(
                                              context)
                                          .updateProfile(
                                        email: emailController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        id: _.user.id,
                                      );
                                    } else {
                                      final authBloc =
                                          BlocProvider.of<AuthCubit>(context);
                                      await authBloc.adminRegister(
                                        email: emailController.text,
                                        name: nameController.text,
                                        phone: phoneController.text,
                                      );
                                    }
                                  },
                                ),
                        ),
                        gapH12,
                      ],
                    );
                  },
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
