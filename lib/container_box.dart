import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextBox extends StatelessWidget {
  final String text;

  TextBox({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
