import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final List inputList;
  final int binSize;
  const ResultPage({required this.inputList, required this.binSize});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

int typeNum = 0;

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    //print("input : " + widget.inputList.toString());
    double boxWidth = MediaQuery.of(context).size.width - 50;
    double boxHeight = MediaQuery.of(context).size.height - 250;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("통 채우기"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              getTypeButton(0, "처음\n적합"),
              getTypeButton(1, "다음\n적합"),
              getTypeButton(2, "최선\n적합"),
              getTypeButton(3, "최악\n적합")
            ]),
            SizedBox(height: 10),
            getResultBox(widget.inputList, widget.binSize, boxWidth, boxHeight)
          ],
        ));
  }

  Widget getTypeButton(int num, String text) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: ElevatedButton(
          onPressed: () {
            setState(() {
              typeNum = num;
            });
          },
          child: Text(text)),
    );
  }
}

Widget getResultBox(List inputList, int binSize, double width, double height) {
  List<List<int>> resultList = typeNum == 0
      ? getFirstFitResult(inputList, binSize)
      : typeNum == 1
          ? getNextFitResult(inputList, binSize)
          : typeNum == 2
              ? getBestFitResult(inputList, binSize)
              : getWorstFitResult(inputList, binSize);

  // for debugging
  String str = "";

  for (int i = 0; i < resultList.length; i++) {
    str = str + " " + resultList[i].toString();
  }
  print("values : " + str);
//////////////////////////////////

  List<Widget> boxes = [];

  // scale 구하기
  double binWidthScale =
      (width / (4 * (resultList.length) - 1)); // 3칸은 한 가로 넓이, 1칸은 여백
  double binHeightScale = height / binSize;

  // 각 사각형 넣기
  for (int i = 0; i < resultList.length; i++) {
    boxes.add(Positioned(
        bottom: 0,
        left: i * binWidthScale * 4,
        child: Container(
          width: binWidthScale * 3,
          height: binHeightScale * binSize,
          color: Color.fromARGB(255, 201, 201, 201),
        )));
  }

  // 각 요소 사각형
  for (int i = 0; i < resultList.length; i++) {
    double top = 0;
    for (int j = 0; j < resultList[i].length; j++) {
      boxes.add(Positioned(
          bottom: top,
          left: i * binWidthScale * 4,
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 131, 148, 202),
                border: Border.all(color: Color.fromARGB(255, 7, 10, 15))),
            width: binWidthScale * 3,
            height: binHeightScale * resultList[i][j],
            child: Center(
              child: Text(resultList[i][j].toString()),
            ),
          )));
      top += binHeightScale * resultList[i][j];
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

List<List<int>> getFirstFitResult(List inputList, int binSize) {
  List<List<int>> outputList = [];

  for (int i = 0; i < inputList.length; i++) {
    bool hasSpace = false;
    for (int j = 0; j < outputList.length; j++) {
      int binLeftSpace = binSize - outputList[j].fold(0, (p, c) => p + c);

      if (inputList[i] <= binLeftSpace) {
        hasSpace = true;
        outputList[j].add(inputList[i]);
        break;
      }
    }
    if (!hasSpace) outputList.add([inputList[i]]);
  }

  return outputList;
}

List<List<int>> getNextFitResult(List inputList, int binSize) {
  List<List<int>> outputList = [];

  int currIndex = -1;
  for (int i = 0; i < inputList.length; i++) {
    if (currIndex == -1) {
      outputList.add([inputList[i]]);
      currIndex = outputList.length - 1;
    } else {
      int binLeftSpace =
          binSize - outputList[currIndex].fold(0, (p, c) => p + c);

      if (inputList[i] <= binLeftSpace) {
        outputList[currIndex].add(inputList[i]);
      } else {
        outputList.add([inputList[i]]);
        currIndex = outputList.length - 1;
      }
    }
  }

  return outputList;
}

List<List<int>> getBestFitResult(List inputList, int binSize) {
  List<List<int>> outputList = [];

  for (int i = 0; i < inputList.length; i++) {
    bool hasSpace = false;
    int minBinLeftSpace = -1;
    int minIndex = -1;

    // 최소인 공간 찾기
    for (int j = 0; j < outputList.length; j++) {
      int binLeftSpace = binSize - outputList[j].fold(0, (p, c) => p + c);

      if (inputList[i] <= binLeftSpace) {
        hasSpace = true;

        if (minIndex == -1) {
          minIndex = j;
          minBinLeftSpace = binLeftSpace;
        } else {
          if (minBinLeftSpace < binLeftSpace) {
            continue;
          } else {
            minIndex = j;
            minBinLeftSpace = binLeftSpace;
          }
        }
      }
    }

    if (!hasSpace) {
      outputList.add([inputList[i]]);
    } else {
      outputList[minIndex].add(inputList[i]);
    }
  }

  return outputList;
}

List<List<int>> getWorstFitResult(List inputList, int binSize) {
  List<List<int>> outputList = [];

  for (int i = 0; i < inputList.length; i++) {
    bool hasSpace = false;
    int maxBinLeftSpace = -1;
    int maxIndex = -1;

    // 최대인 공간 찾기
    for (int j = 0; j < outputList.length; j++) {
      int binLeftSpace = binSize - outputList[j].fold(0, (p, c) => p + c);

      if (inputList[i] <= binLeftSpace) {
        hasSpace = true;

        if (maxIndex == -1) {
          maxIndex = j;
          maxBinLeftSpace = binLeftSpace;
        } else {
          if (maxBinLeftSpace > binLeftSpace) {
            continue;
          } else {
            maxIndex = j;
            maxBinLeftSpace = binLeftSpace;
          }
        }
      }
    }

    if (!hasSpace) {
      outputList.add([inputList[i]]);
    } else {
      outputList[maxIndex].add(inputList[i]);
    }
  }

  return outputList;
}
