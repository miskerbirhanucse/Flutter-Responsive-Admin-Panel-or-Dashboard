import 'package:admin/constants.dart';
import 'package:admin/src/dashboard/components/header.dart';
import 'package:admin/src/user/presentation/components/user_table.dart';
import 'package:flutter/material.dart';

class UserDashboardScreen extends StatelessWidget {
  const UserDashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UserTable(title: "User List"),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
