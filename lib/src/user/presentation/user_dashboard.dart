import 'package:admin/constants.dart';
import 'package:admin/src/auth/models/user.dart';
import 'package:admin/src/dashboard/components/header.dart';
import 'package:admin/src/user/bloc/user_cubit.dart';
import 'package:admin/src/user/presentation/components/user_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserDashboardScreen extends StatefulWidget {
  static String id = 'UserDashboardScreen';

  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserListLoading && state.isFirstFetch) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        List<User> userList = [];
        bool isLoading = false;
        if (state is UserListLoading) {
          userList = state.oldUsers!;
          isLoading = true;
        } else if (state is UserListLoaded) {
          userList = state.users!;
        }
        return SafeArea(
          child: SingleChildScrollView(
            primary: false,
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Header(),
                const SizedBox(height: defaultPadding),
                Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          UserTable(
                            title: "User List",
                            userList: userList,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
