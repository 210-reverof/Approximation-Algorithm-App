import 'package:bin_packing_and_job_scheduling_app/job_scheduling/input_val_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InputScheduleNPage extends StatefulWidget {
  @override
  State<InputScheduleNPage> createState() => _InputScheduleNPageState();
}

class _InputScheduleNPageState extends State<InputScheduleNPage> {
  String n = "", c = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              child: Image.asset("assets/background_sub.png"),
            ),
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
                getTopBox(),
                const SizedBox(
                  height: 40,
                ),
                getTextField("inputN"),
                SizedBox(
                  height: 25,
                ),
                getTextField("inputC"),
                SizedBox(
                  height: 50,
                ),
                getNextButton(),
              ],
            ),
          ],
        ));
  }

  Widget getTextField(input) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text(
            input == "inputN"
                ? "작업의 개수 N (1 ~ 20)                                  "
                : "기계의 개수 C (1 ~ 20)                                      ",
            style: TextStyle(
                color: Color.fromARGB(255, 1, 67, 66),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: 300,
            color: Colors.white,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                if (input == "inputN") {
                  n = val;
                } else {
                  c = val;
                }
              },
            ),
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
          Text("작업의 개수와 기계의 개수를\n아래 칸에 입력해주세요",
              style: TextStyle(
                  color: Color.fromARGB(255, 1, 67, 66),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center),
          SizedBox(
            height: 15,
          ),
          Text(
            "N, C은 1부터 20까지의 자연수",
            style: TextStyle(
                color: Color.fromARGB(255, 118, 230, 182),
                fontSize: 13,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget getNextButton() {
    return ElevatedButton(
      onPressed: () {
        if (n == "" || c == "") {
          Fluttertoast.showToast(
              msg: "값을 입력해주세요",
              toastLength: Toast.LENGTH_LONG,
              fontSize: 14,
              backgroundColor: Colors.grey);
        } else {
          int nNum = int.parse(n);
          int cNum = int.parse(c);
          print(nNum.toString() + " " + cNum.toString());
          if (nNum < 1 || nNum > 20) {
            Fluttertoast.showToast(
                msg: "알맞은 N값을 입력해주세요",
                toastLength: Toast.LENGTH_LONG,
                fontSize: 14,
                backgroundColor: Colors.grey);
          } else if (cNum < 1 || cNum > 20) {
            Fluttertoast.showToast(
                msg: "알맞은 C값을 입력해주세요",
                toastLength: Toast.LENGTH_LONG,
                fontSize: 14,
                backgroundColor: Colors.grey);
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InputValPage(
                        objCnt: nNum,
                        machineCnt: cNum,
                      )),
            );
          }
        }
      },
      child: Text("     입력 완료     ",
          style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontWeight: FontWeight.bold)),
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 95, 197, 153), // This is what you need!
      ),
    );
  }
}
