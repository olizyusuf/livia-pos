import 'package:flutter/material.dart';
import 'package:liviapos/model/role.dart';
import 'package:liviapos/provider/role_provider.dart';
import 'package:provider/provider.dart';

import '../helper/display_helper.dart';

class RoleFormScreen extends StatelessWidget {
  const RoleFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DisplayHelper displayHelper = DisplayHelper();

    RoleProvider roleProv = Provider.of<RoleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(roleProv.title),
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
              TextFormField(
                controller: roleProv.cNama,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Nama Role',
                  hintStyle: const TextStyle(color: Colors.black26),
                  fillColor: roleProv.title != 'Add Role'
                      ? Colors.grey[400]
                      : Colors.grey[100],
                  filled: true,
                  labelText: 'Nama Role',
                ),
                readOnly: roleProv.title != 'Add Role' ? true : false,
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                  color: Colors.grey[100],
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  height: displayHelper.heightDp(context) * 0.7,
                  child: Consumer<RoleProvider>(
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
                                value: prov.permission![index] != '0'
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
                  roleProv.title != 'Add Role'
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
                                        if (roleProv.nama != 'ADMINISTRATOR') {
                                          roleProv.deleteRole();
                                          Navigator.of(context).pop(true);
                                        }
                                      },
                                      child: const Text('Ya'),
                                    ),
                                  ],
                                );
                              },
                            ).then(
                              (value) {
                                if (value) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(roleProv.message!)));
                                }
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
                      if (roleProv.title != 'Add Role') {
                        roleProv.updateRole().then(
                          (value) {
                            if (roleProv.message!.contains('berhasil')) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(roleProv.message!)));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(roleProv.message!)));
                            }
                          },
                        );
                      } else {
                        roleProv
                            .insertRole(Role(
                                nama: roleProv.cNama.text.toUpperCase(),
                                permission: roleProv.permission!.join()))
                            .then(
                          (value) {
                            if (roleProv.message!.contains('berhasil')) {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(roleProv.message!)));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(roleProv.message!)));
                            }
                          },
                        );
                      }
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
