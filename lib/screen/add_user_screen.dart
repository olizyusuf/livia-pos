import 'package:flutter/material.dart';
import 'package:liviapos/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../helper/display_helper.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProv = Provider.of<UserProvider>(context, listen: false);

    DisplayHelper displayHelper = DisplayHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text(userProv.title),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        width: displayHelper.widthDp(context),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 10.0),
          child: Column(
            children: [
              TextField(
                controller: userProv.cUsername,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Username',
                  hintStyle: const TextStyle(color: Colors.black26),
                  fillColor: userProv.title != 'Add User'
                      ? Colors.grey[400]
                      : Colors.grey[100],
                  filled: true,
                  labelText: 'Username',
                ),
                readOnly: userProv.title != 'Add User' ? true : false,
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: userProv.cPassword,
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Password',
                  hintStyle: const TextStyle(color: Colors.black26),
                  fillColor: Colors.grey[100],
                  filled: true,
                  labelText: 'Password',
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: userProv.cRePassword,
                obscureText: true,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Re-Password',
                  hintStyle: const TextStyle(color: Colors.black26),
                  fillColor: Colors.grey[100],
                  filled: true,
                  labelText: 'Re-Password',
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Consumer<UserProvider>(
                builder: (context, prov, child) {
                  return DropdownButtonFormField<String>(
                    value: prov.role,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintStyle: const TextStyle(color: Colors.black26),
                      fillColor: Colors.grey[100],
                      filled: true,
                      labelText: 'Role',
                    ),
                    items: prov.roles.map((String valrole) {
                      return DropdownMenuItem<String>(
                        value: valrole,
                        child: Text(valrole),
                      );
                    }).toList(),
                    onChanged: (String? valrole) {
                      prov.role = valrole!;
                      debugPrint(prov.role);
                    },
                  );
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Simpan',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              userProv.title != 'Add User'
                  ? TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              // To display the title it is optional
                              title: const Text('Peringatan'),
                              // Message which will be pop up on the screen
                              content: const Text('Apakah data ingin dihapus?'),
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
                        'Hapus Akun',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  : const SizedBox(
                      height: 15.0,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
