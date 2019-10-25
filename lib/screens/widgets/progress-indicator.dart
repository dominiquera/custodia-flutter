import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressIndicatorWithPadding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: 40,
      height: 40,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
