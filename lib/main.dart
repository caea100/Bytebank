import 'dart:html';
import 'dart:js';

import 'package:flutter/material.dart';
import 'package:fluttertest/screens/transferencia/lista.dart';

void main() => runApp(Bytebank());

class Bytebank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
        ).copyWith(secondary: Colors.black),
      ),
      home: ListaTrasferencias(),
    );
  }
}
