import 'package:admin/constants.dart';
import 'package:admin/models/RecentFile.dart';
import 'package:admin/src/user/models/user_data.dart';
import 'package:admin/utils/colors.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class UserTable extends StatelessWidget {
  const UserTable({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: DataTable2(
              columnSpacing: defaultPadding,
              minWidth: 600,
              columns: [
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
                demoUser.length,
                (index) => recentUserRow(demoUser[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentUserRow(UserData fileInfo) {
  return DataRow(
    cells: [
      DataCell(Text(fileInfo.name!)),
      DataCell(Text(fileInfo.status!)),
      DataCell(Text(fileInfo.email!)),
      DataCell(Text(fileInfo.phone!)),
      DataCell(Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )
        ],
      )),
    ],
  );
}
