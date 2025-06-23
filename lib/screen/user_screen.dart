import 'package:flutter/material.dart';
import 'package:liviapos/helper/display_helper.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context, listen: false);

    userProv.getRoles();
    userProv.getUsers();

    String title = "Users";

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
                        Navigator.pushNamed(context, '/roles');
                      },
                      child: const Text("Role"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        userProv.initAddUser();
                        Navigator.pushNamed(context, '/add_user');
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
                    itemCount: prov.users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(prov.users[index].username),
                        subtitle: Text(
                          prov.users[index].role,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            userProv.initEditUser(prov.users[index].username);

                            Navigator.pushNamed(context, '/add_user');
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
