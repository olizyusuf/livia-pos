import 'package:flutter/material.dart';

import '../helper/display_helper.dart';

class MasterScreen extends StatelessWidget {
  const MasterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DisplayHelper displayHelper = DisplayHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text('Master Data'),
      ),
      body: SizedBox(
        width: displayHelper.widthDp(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Kategori'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/produk');
                  },
                  child: Text('Produk'),
                ),
              ],
            ),
            SizedBox(
              height: 15.0,
            ),
            ListTile(
              title: Text('Total Produk'),
              subtitle: Text('100'),
            ),
            Divider(
              thickness: 1.0,
            ),
            ListTile(
              title: Text('Stok Minim'),
              subtitle: Text('100'),
            ),
            Divider(
              thickness: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
