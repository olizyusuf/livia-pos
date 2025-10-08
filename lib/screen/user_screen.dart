import 'package:flutter/material.dart';
import 'package:liviapos/helper/display_helper.dart';
import 'package:liviapos/provider/role_provider.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DisplayHelper displayHelper = DisplayHelper();

    String title = "Users";

    UserProvider userProv = Provider.of<UserProvider>(context, listen: false);
    userProv.getUsers();

    RoleProvider roleProv = Provider.of<RoleProvider>(context, listen: false);
    roleProv.getRoles();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SizedBox(
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
                        userProv.initAddForm();
                        Navigator.pushNamed(context, '/form_user');
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
                      if (prov.users.isNotEmpty) {
                        return ListTile(
                          title: Text(prov.users[index]['username']),
                          subtitle: Text(
                            prov.users[index]['role'],
                            style: const TextStyle(fontSize: 12.0),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              userProv
                                  .initEditForm(prov.users[index]['username']);
                              Navigator.pushNamed(context, '/form_user');
                            },
                            icon: const Icon(Icons.edit_square),
                          ),
                          tileColor:
                              index % 2 == 0 ? Colors.white : Colors.grey[200],
                        );
                      } else {
                        return const Center(
                          child: Text('Empty...'),
                        );
                      }
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
