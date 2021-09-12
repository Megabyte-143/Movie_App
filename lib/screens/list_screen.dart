import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: height * 0.3,
            color: Colors.red,
          ),
          Container(
            height: height * 0.6,
          ),
          Container(
            height: height * 0.1,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
