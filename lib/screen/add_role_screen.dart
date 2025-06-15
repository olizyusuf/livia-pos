import 'package:flutter/material.dart';
import 'package:liviapos/model/role.dart';
import 'package:provider/provider.dart';

import '../helper/display_helper.dart';
import '../provider/user_provider.dart';

class AddRoleScreen extends StatelessWidget {
  const AddRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context, listen: false);
    Role? dataRole = ModalRoute.of(context)?.settings.arguments as Role?;

    debugPrint(dataRole.toString());

    if (dataRole != null) {
      userProv.initEditRole(dataRole);
    } else {
      userProv.initAddRole();
    }

    String titleAdd = "Add Role";
    String titleEdit = "Edit Role";

    DisplayHelper displayHelper = DisplayHelper();

    return Scaffold(
      appBar: AppBar(
        title: dataRole != null ? Text(titleEdit) : Text(titleAdd),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          top: 10.0,
          left: 8.0,
          right: 8.0,
        ),
        width: displayHelper.widthDp(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: userProv.cNamaRole,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Nama Role',
                  hintStyle: const TextStyle(color: Colors.black26),
                  fillColor:
                      dataRole != null ? Colors.grey[400] : Colors.grey[100],
                  filled: true,
                  labelText: 'Nama Role',
                ),
                readOnly: dataRole != null ? true : false,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                  color: Colors.grey[100],
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  height: displayHelper.heightDp(context) * 0.7,
                  child: Consumer<UserProvider>(
                    builder: (context, prov, child) {
                      return ListView.builder(
                        itemCount: prov.menus.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: index % 2 == 0
                                ? Colors.grey[100]
                                : Colors.white,
                            child: ListTile(
                              title: Text(prov.menus[index]),
                              trailing: Checkbox(
                                activeColor: Colors.green,
                                checkColor: Colors.white,
                                value: prov.permission[index] != '0'
                                    ? true
                                    : false,
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    prov.changePermission(index, newValue);
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  dataRole != null
                      ? TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  // To display the title it is optional
                                  title: const Text('Peringatan'),
                                  // Message which will be pop up on the screen
                                  content:
                                      const Text('Apakah data ingin dihapus?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: const Text('Batal'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(true);
                                      },
                                      child: const Text('Ya'),
                                    ),
                                  ],
                                );
                              },
                            ).then(
                              (value) {
                                if (value) Navigator.of(context).pop();
                              },
                            );
                          },
                          child: const Text(
                            'Hapus Role',
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : const SizedBox(
                          width: 0,
                        ),
                  ElevatedButton(
                    onPressed: () {
                      userProv.addPermission(userProv.permission.join());
                    },
                    child: const Text('Simpan'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
