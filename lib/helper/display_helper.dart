import 'package:flutter/material.dart';

class DisplayHelper {
  double heightDp(BuildContext context) {
    double height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return height;
  }

  double widthDp(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width;
  }
}
