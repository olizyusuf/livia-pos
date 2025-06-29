import 'package:flutter/material.dart';
import 'package:liviapos/provider/role_provider.dart';
import 'package:provider/provider.dart';

import '../helper/display_helper.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "Roles";

    DisplayHelper displayHelper = DisplayHelper();

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
                        roleProv.initAddForm();
                        Navigator.pushNamed(context, '/form_role');
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
            Consumer<RoleProvider>(
              builder: (context, prov, child) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: prov.roles.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(prov.roles[index]['nama']),
                        trailing: IconButton(
                          onPressed: () {
                            prov.initEditForm(prov.roles[index]['nama']);
                            Navigator.pushNamed(context, '/form_role');
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
