import 'package:flutter/material.dart';

import '../helper/display_helper.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                        Navigator.pushNamed(context, '/roles');
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
            SizedBox(
              height: displayHelper.heightDp(context) * 0.88,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("Administrator ${index.toString()}"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_square),
                    ),
                    tileColor: index % 2 == 0 ? Colors.white : Colors.grey[200],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
