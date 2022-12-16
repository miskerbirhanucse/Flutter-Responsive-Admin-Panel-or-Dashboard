import 'package:admin/constants.dart';
import 'package:admin/src/auth/models/user.dart';
import 'package:admin/src/user/bloc/user_detail_cubit.dart';
import 'package:admin/src/user/presentation/create_user.dart';
import 'package:admin/utils/utils.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user_cubit.dart';

class UserTable extends StatelessWidget {
  const UserTable({
    Key? key,
    required this.title,
    required this.userList,
  }) : super(key: key);
  final String title;
  final List<User> userList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const CreateUser(
                        title: "Create User",
                        buttonText: 'create',
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: CustomColor.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Add User',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ),
              )
            ],
          ),
          gapH8,
          SizedBox(
            height: 400,
            width: double.infinity,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: const [
                DataColumn(
                  label: Text("Name"),
                ),
                DataColumn(
                  label: Text("Status"),
                ),
                DataColumn(
                  label: Text("Email"),
                ),
                DataColumn(
                  label: Text("Phone"),
                ),
                DataColumn(
                  label: Text("Action"),
                ),
              ],
              rows: List.generate(
                userList.length,
                (index) => recentUserRow(userList[index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentUserRow(User fileInfo, BuildContext context) {
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.name ?? '')),
      DataCell(Text(fileInfo.status.toString())),
      DataCell(Text(fileInfo.email ?? "")),
      DataCell(Text(fileInfo.phone ?? "")),
      DataCell(Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateUser(
                    title: 'Edit User',
                    buttonText: "update",
                    isEdit: true,
                    status: fileInfo.status,
                  ),
                ),
              );
              BlocProvider.of<UserDetailCubit>(context)
                  .getUser(id: fileInfo.id);
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              BlocProvider.of<UserCubit>(context).deleteUser(id: fileInfo.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      )),
    ],
  );
}
