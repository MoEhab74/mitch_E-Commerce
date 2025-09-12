// Padding Extention
import 'package:flutter/material.dart';

extension PaddingExtention on Widget {
  Widget withPadding([double value = 8]) {
    return Padding(padding: EdgeInsets.all(value), child: this);
  }
}
  // Center extention for any widget
  extension CenterExtention on Widget {
    Widget withCenter() {
      return Center(child: this);
    }
  }

