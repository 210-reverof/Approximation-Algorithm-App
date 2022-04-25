import 'package:bin_packing_and_job_scheduling_app/bin_packing/result_page.dart';
import 'package:flutter/material.dart';

class InputValPage extends StatefulWidget {
  final int objCnt, binSize;
  const InputValPage({required this.objCnt, required this.binSize});

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
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
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
                          inputList: [7, 5, 6, 4, 2, 3, 7, 5],
                          binSize: 10,
                        )),
              );
            },
            child: Text("값 입력 완료")),
      ),
    );

    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("통 채우기"),
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
    child: Column(
      children: [
        Text((i + 1).toString() + "번째 요소를 입력해주세요"),
        SizedBox(
          height: 10,
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          onChanged: (val) {
            inputVal[i] = val;
          },
        ),
      ],
    ),
  );
}
