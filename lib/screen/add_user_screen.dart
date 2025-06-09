import 'package:flutter/material.dart';

import '../helper/display_helper.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "Add User";

    DisplayHelper displayHelper = DisplayHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        width: displayHelper.widthDp(context),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    hintText: 'Username',
                    fillColor: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
