import 'package:bin_packing_and_job_scheduling_app/bin_packing/input_val_page.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class InputNPage extends StatefulWidget {
  @override
  State<InputNPage> createState() => _InputNPageState();
}

class _InputNPageState extends State<InputNPage> {
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
                  "통 채우기",
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
                ? "물건의 개수 N (1 ~ 20)                                  "
                : "통의 크기 C (N ~ 20)                                      ",
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
          Text("통에 넣을 물건의 개수와 통의 크기를\n아래 칸에 입력해주세요",
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
          } else if (cNum < nNum || cNum > 20) {
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
                        binSize: cNum,
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
