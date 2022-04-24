import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final List inputList;
  final int machineCnt;
  const ResultPage({required this.inputList, required this.machineCnt});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

int typeNum = 0;

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    double boxWidth = MediaQuery.of(context).size.width - 40;
    double boxHeight = MediaQuery.of(context).size.height - 550;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("작업 스케줄링 문제"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getResultBox(
                widget.inputList, widget.machineCnt, boxWidth, boxHeight)
          ],
        ));
  }
}

Widget getResultBox(
    List inputList, int machineCnt, double width, double height) {
  List<List<int>> resultList = getResult(inputList, machineCnt);
  // for debugging
  String str = "";

  for (int i = 0; i < resultList.length; i++) {
    str = str + " " + resultList[i].toString();
  }
  print("values : " + str);
//////////////////////////////////

  List<Widget> boxes = [];

  int maxIndex = 0;
  int max = resultList[0].fold(0, (p, c) => p + c);
  for (int i = 0; i < resultList.length; i++) {
    int tmp = resultList[i].fold(0, (p, c) => p + c);
    if (max < tmp) {
      max = tmp;
      maxIndex = i;
    }
  }

  // scale 구하기
  double binWidthScale = width / max * 0.9; // 3칸은 한 가로 넓이, 1칸은 여백
  double binHeightScale = (height / (4 * (resultList.length) - 1));

  // 각 요소 사각형
  for (int i = 0; i < resultList.length; i++) {
    double end = 0;
    for (int j = 0; j < resultList[i].length; j++) {
      boxes.add(Positioned(
          left: end,
          top: i * binHeightScale * 4,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 131, 148, 202),
                border: Border.all(color: Color.fromARGB(255, 7, 10, 15))),
            width: binWidthScale * resultList[i][j],
            height: binHeightScale * 3,
            child: Center(
              child: Text(resultList[i][j].toString()),
            ),
          )));
      end += binWidthScale * resultList[i][j];
    }
  }

  return Center(
    child: Container(
      color: Colors.white,
      width: width,
      height: height,
      child: Stack(
        children: boxes,
      ),
    ),
  );
}

List<List<int>> getResult(List inputList, int machineCnt) {
  List<List<int>> outputList = [];
  for (int i = 0; i < machineCnt; i++) {
    outputList.add([]);
  }
  for (int i = 0; i < inputList.length; i++) {
    int minSum = outputList[0].fold(0, (p, c) => p + c);
    int minIndex = 0;

    for (int j = 1; j < machineCnt; j++) {
      int currSum = outputList[j].fold(0, (p, c) => p + c);
      if (minSum > currSum) {
        minIndex = j;
        minSum = currSum;
      }
    }

    outputList[minIndex].add(inputList[i]);
  }

  //outputList = outputList.reversed.toList();
  return outputList;
}
