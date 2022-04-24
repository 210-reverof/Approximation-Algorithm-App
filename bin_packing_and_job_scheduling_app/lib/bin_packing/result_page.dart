import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final List inputList;
  final int binSize;
  const ResultPage({required this.inputList, required this.binSize});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.inputList.toString());

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("통 채우기"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [getResultBox(widget.inputList, widget.binSize)],
        ));
  }
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

Widget getResultBox(List inputList, int binSize) {
  List<List<int>> outputList = getNextFitResult(inputList, binSize);
  String str = "";

  for (int i = 0; i < outputList.length; i++) {
    str = str + " " + outputList[i].toString();
  }
  return Container(color: Colors.amber, child: Text(str));
}
