import 'package:flutter/material.dart';

class DisplayHelper {
  double heightDp(context) {
    double height = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).padding.top;
    return height;
  }

  double widthDp(context) {
    double width = MediaQuery.of(context).size.width;
    return width;
  }
}
