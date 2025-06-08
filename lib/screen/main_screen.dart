import 'package:flutter/material.dart';

import '../helper/display_helper.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String titleApp = "Livia POS";

    DisplayHelper displayHelper = DisplayHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text(titleApp),
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            );
          },
        ),
      ),
      body: Container(
        height: displayHelper.heightDp(context),
        width: displayHelper.widthDp(context),
        child: Center(
          child: Text("main screen"),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const SizedBox(
              height: 90,
              child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Administrator',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ],
                  )),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Main"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/main');
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text("Penjualan"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/main');
              },
            ),
            ListTile(
              leading: const Icon(Icons.input_outlined),
              title: const Text("Pembelian"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/main');
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard_outlined),
              title: const Text("Master"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/main');
              },
            ),
            const Divider(
              color: Colors.black45,
            ),
            ListTile(
              leading: const Icon(Icons.data_thresholding_outlined),
              title: const Text("Laporan"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/main');
              },
            ),
            const Divider(
              color: Colors.black45,
            ),
            ListTile(
              leading: const Icon(Icons.person_3_outlined),
              title: const Text("Users"),
              onTap: () {
                Navigator.pushNamed(context, '/users');
              },
            ),
            ListTile(
              leading: const Icon(Icons.print_rounded),
              title: const Text("Printer"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/main');
              },
            ),
            ListTile(
              leading: const Icon(Icons.save),
              title: const Text("Database"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/main');
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings_applications_outlined),
              title: const Text("Setting"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/main');
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/main');
              },
            ),
          ],
        ),
      ),
    );
  }
}
