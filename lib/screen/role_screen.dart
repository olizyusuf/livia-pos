import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helper/display_helper.dart';
import '../provider/user_provider.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context, listen: false);

    userProv.getRoles();

    String title = "Roles";

    DisplayHelper displayHelper = DisplayHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        height: displayHelper.heightDp(context),
        width: displayHelper.widthDp(context),
        child: Column(
          children: [
            SizedBox(
              height: displayHelper.heightDp(context) * 0.12,
              child: Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        userProv.initAddRole();
                        Navigator.pushNamed(context, '/add_role');
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.add),
                          Text("Tambah"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Consumer<UserProvider>(
              builder: (context, prov, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: prov.roles.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(prov.roles[index]),
                        trailing: IconButton(
                          onPressed: () {
                            prov.initEditRole(prov.roles[index]);
                            Navigator.pushNamed(context, '/add_role');
                          },
                          icon: const Icon(Icons.edit_square),
                        ),
                        tileColor:
                            index % 2 == 0 ? Colors.white : Colors.grey[200],
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
