import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Padding symmetricPadding({double horizontal = 0, double vertical = 0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Padding allPadding(double padding) {
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }

  Padding onlyPadding({
    double top = 0,
    double right = 0,
    double left = 0,
    double bottom = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        bottom: bottom,
        right: right,
        left: left,
      ),
      child: this,
    );
  }
}
