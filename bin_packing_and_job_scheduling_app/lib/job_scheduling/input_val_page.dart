import 'package:bin_packing_and_job_scheduling_app/job_scheduling/result_page.dart';
import 'package:flutter/material.dart';

class InputValPage extends StatefulWidget {
  final int objCnt, machineCnt;
  const InputValPage({required this.objCnt, required this.machineCnt});

  @override
  State<InputValPage> createState() => _InputValPageState();
}

List inputVal = [];
List<Widget> inputWidget = [];

class _InputValPageState extends State<InputValPage> {
  @override
  Widget build(BuildContext context) {
    // for debug init lists
    inputVal = [];
    inputWidget = [];

    for (int i = 0; i < widget.objCnt; i++) {
      inputVal.add(0);
      inputWidget.add(getInputTextField(i));
    }
    inputWidget.add(
      ElevatedButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => ResultPage(
            //             inputList: inputVal,
            //             binSize: widget.binSize,
            //           )),
            // );

            // for debugging
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ResultPage(
                        inputList: [5, 2, 4, 3, 4, 7, 9, 2, 4, 1],
                        machineCnt: 4,
                      )),
            );
          },
          child: Text("값 입력 완료")),
    );

    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("작업 스케줄링"),
        ),
        body: Container(
          child: ListView(
            children: inputWidget,
          ),
        ));
  }
}

Widget getInputTextField(int i) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    child: TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
      ),
      onChanged: (val) {
        inputVal[i] = val;
      },
    ),
  );
}
