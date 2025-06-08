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
              height: displayHelper.heightDp(context) * 0.1,
              child: Container(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("Role"),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_box_outlined,
                        size: 35,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: displayHelper.heightDp(context) * 0.9,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("index " + index.toString()),
                    subtitle: Text("Administrator"),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.edit_square),
                    ),
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
