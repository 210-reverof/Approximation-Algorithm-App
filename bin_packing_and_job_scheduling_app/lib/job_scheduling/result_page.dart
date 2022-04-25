import 'package:flutter/material.dart';
import 'package:bin_packing_and_job_scheduling_app/colorLists.dart';

class ResultPage extends StatefulWidget {
  final List inputList;
  final int machineCnt;
  const ResultPage({required this.inputList, required this.machineCnt});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

int typeNum = 0;

class _ResultPageState extends State<ResultPage> {
  int jobResultEnd = 0;
  @override
  Widget build(BuildContext context) {
    double boxWidth = 300;
    double boxHeight = 300;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              child: Image.asset("assets/background_sub.png"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 20,
                        height: 20,
                        margin: EdgeInsets.only(right: 300),
                        child: Image.asset("assets/btn_back.png"),
                      ),
                    ),
                    const Text(
                      "작업 스케줄링",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    getMainBox(boxWidth, boxHeight),
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  Container getMainBox(double boxWidth, double boxHeight) {
    return Container(
      width: 360,
      height: 550,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 0),
            blurRadius: 15,
            color: Colors.black.withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {},
              child: Text("작업 스케줄링",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 95, 197, 153),
              )),
          SizedBox(height: 20),
          getResultBox(
              widget.inputList, widget.machineCnt, boxWidth, boxHeight),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 231, 229, 229),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            width: 340,
            height: 50,
            child:
                Center(child: Text("주어진 작업을 모두 완료를 위한 최소 시간 : $jobResultEnd")),
          )
        ],
      ),
    );
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
    double scheduleWidthScale = width / max * 0.9; // 3칸은 한 가로 넓이, 1칸은 여백
    double scheduleHeightScale = (height / (4 * (resultList.length) - 1));

    // 각 요소 사각형
    for (int i = 0; i < resultList.length; i++) {
      double end = 0;
      for (int j = 0; j < resultList[i].length; j++) {
        boxes.add(Positioned(
            left: end,
            top: i * scheduleHeightScale * 4,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                //color: Color.fromARGB(255, 131, 148, 202),
                color: i == maxIndex
                    ? colorListBLong[j % 4]
                    : colorListBNoraml[j % 4],
                //border: Border.all(color: Color.fromARGB(255, 7, 10, 15))
              ),
              width: scheduleWidthScale * resultList[i][j],
              height: scheduleHeightScale * 3,
              child: Center(
                child: Text(resultList[i][j].toString()),
              ),
            )));
        end += scheduleWidthScale * resultList[i][j];
      }
    }

    // 최종 마감 시간 표시
    boxes.add(Positioned(
      left: max * scheduleWidthScale,
      top: maxIndex * scheduleHeightScale * 4,
      child: Container(
        margin: const EdgeInsets.only(left: 5),
        height: scheduleHeightScale * 3,
        child: Center(child: Text(max.toString())),
      ),
    ));

    jobResultEnd = max;

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
}
