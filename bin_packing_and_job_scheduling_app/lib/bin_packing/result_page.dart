import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final List num;
  const ResultPage({required this.num});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.num.toString());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("통 채우기"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [getResultBox(widget.num)],
        ));
  }
}

Widget getResultBox(List arr) {
  return Container(color: Colors.amber, child: Text(arr.toString()));
}
