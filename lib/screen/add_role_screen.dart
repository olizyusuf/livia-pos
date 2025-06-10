import 'package:flutter/material.dart';

import '../helper/display_helper.dart';

class AddRoleScreen extends StatelessWidget {
  const AddRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "Add Role";

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
                  hintText: 'Nama Role',
                  hintStyle: TextStyle(color: Colors.black26),
                  fillColor: Colors.grey[100],
                  filled: true,
                  labelText: 'Nama Role',
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Checkbox(
                activeColor: Colors.yellow,
                checkColor: Colors.black,
                value: true,
                onChanged: (newValue) {},
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
