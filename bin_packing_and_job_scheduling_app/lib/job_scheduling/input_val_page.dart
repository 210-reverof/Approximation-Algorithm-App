import 'package:bin_packing_and_job_scheduling_app/job_scheduling/result_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InputValPage extends StatefulWidget {
  final int objCnt, machineCnt;
  const InputValPage({required this.objCnt, required this.machineCnt});

  @override
  State<InputValPage> createState() => _InputValPageState();
}

List<int> inputVal = [];
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

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              child: Image.asset("assets/background_sub.png"),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(
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
                      getTopBox(),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 300,
                        height: 380,
                        child: SingleChildScrollView(
                          child: Column(
                            children: inputWidget,
                          ),
                        ),
                      ),
                      getNextButton()
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget getNextButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () {
            print(inputVal.toString());
            bool hasZero = false;
            for (int i = 0; i < inputVal.length; i++) {
              if (inputVal[i] == 0) {
                hasZero = true;
                break;
              }
            }
            if (hasZero) {
              Fluttertoast.showToast(
                  msg: "모든 요소의 값을 입력해주세요",
                  toastLength: Toast.LENGTH_LONG,
                  fontSize: 14,
                  backgroundColor: Colors.grey);
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResultPage(
                          inputList: inputVal,
                          machineCnt: widget.machineCnt,
                        )),
              );

              // for debugging
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => const ResultPage(
              //             inputList: [7, 5, 6, 4, 2, 3, 7, 5],
              //             machineCnt: 10,
              //           )),
              // );
            }
          },
          child: Text("     입력 완료     ",
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold)),
          style: ElevatedButton.styleFrom(
            primary:
                Color.fromARGB(255, 95, 197, 153), // This is what you need!
          )),
    );
  }
}

Widget getInputTextField(int i) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        Text(
          (i + 1).toString() +
              "번째 수행 시간                                                                 ",
          style: TextStyle(
              color: Color.fromARGB(255, 1, 67, 66),
              fontSize: 12,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
          onChanged: (val) {
            if (val.toString() == "") {
              inputVal[i] = 0;
            } else {
              inputVal[i] = int.parse(val);
            }
            print(inputVal.toString() + " ");
          },
        ),
      ],
    ),
  );
}

Widget getTopBox() {
  return Container(
    width: 320,
    height: 125,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(25)),
      boxShadow: [
        BoxShadow(
          offset: Offset(0, 0),
          blurRadius: 15,
          color: Colors.black.withOpacity(0.3),
        ),
      ],
    ),
    child: Column(
      children: [
        Text("수행해야 할 작업의 각 수행 시간을\n 아래 칸에 모두 입력해주세요",
            style: TextStyle(
                color: Color.fromARGB(255, 1, 67, 66),
                fontSize: 16,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center),
        SizedBox(
          height: 15,
        ),
        Text(
          "모든 크기는 1부터 20까지의 자연수",
          style: TextStyle(
              color: Color.fromARGB(255, 118, 230, 182),
              fontSize: 13,
              fontWeight: FontWeight.bold),
        )
      ],
    ),
  );
}
