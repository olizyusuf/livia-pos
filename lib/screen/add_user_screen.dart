import 'package:flutter/material.dart';

import '../helper/display_helper.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "Add User";

    DisplayHelper displayHelper = DisplayHelper();

    List<String> roles = ['Administrator', 'Kasir', 'Manager'];
    String defaultRole = 'Administrator';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Username',
                  hintStyle: TextStyle(color: Colors.black26),
                  fillColor: Colors.grey[100],
                  filled: true,
                  labelText: 'Username',
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.black26),
                  fillColor: Colors.grey[100],
                  filled: true,
                  labelText: 'Password',
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Re-Password',
                  hintStyle: TextStyle(color: Colors.black26),
                  fillColor: Colors.grey[100],
                  filled: true,
                  labelText: 'Re-Password',
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              DropdownButton(
                value: defaultRole,
                items: roles.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  defaultRole = value.toString();
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
