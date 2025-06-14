import 'package:flutter/material.dart';

import '../helper/display_helper.dart';

class AddRoleScreen extends StatelessWidget {
  const AddRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String title = "Add Role";

    List<String> menus = [
      "Penjualan",
      "Pembelian",
      "Master",
      "Laporan",
      "Users",
      "Printer",
      "Database",
      "Setting"
    ];

    DisplayHelper displayHelper = DisplayHelper();

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
                  border: const OutlineInputBorder(),
                  hintText: 'Nama Role',
                  hintStyle: const TextStyle(color: Colors.black26),
                  fillColor: Colors.grey[100],
                  filled: true,
                  labelText: 'Nama Role',
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Container(
                color: Colors.grey[100],
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                height: displayHelper.heightDp(context) * 0.7,
                child: ListView.builder(
                  itemCount: menus.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: index % 2 == 0 ? Colors.grey[100] : Colors.white,
                      child: ListTile(
                        title: Text(menus[index]),
                        trailing: Checkbox(
                          activeColor: Colors.green,
                          checkColor: Colors.white,
                          value: index % 2 == 0 ? true : false,
                          onChanged: (newValue) {},
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 10.0,
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
