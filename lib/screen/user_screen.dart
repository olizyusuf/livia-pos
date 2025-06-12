import 'package:flutter/material.dart';
import 'package:liviapos/helper/display_helper.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("index ${index.toString()}"),
                    subtitle: Text("Administrator"),
                    trailing: IconButton(
                      onPressed: () {
                        final datauser = {
                          "username": "admin${index}",
                          "password": "password",
                        };

                        Navigator.pushNamed(context, '/add_user',
                            arguments: datauser);
                      },
                      icon: Icon(Icons.edit_square),
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
