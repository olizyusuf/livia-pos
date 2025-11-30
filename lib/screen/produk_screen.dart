import 'package:flutter/material.dart';

import '../helper/display_helper.dart';

class ProdukScreen extends StatelessWidget {
  const ProdukScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DisplayHelper displayHelper = DisplayHelper();

    return Scaffold(
      appBar: AppBar(
        title: Text('Produk'),
      ),
      body: Container(
        width: displayHelper.widthDp(context),
        child: Center(
          child: Text('Data masih kosong...'),
        ),
      ),
    );
  }
}
