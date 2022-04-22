import 'package:bin_packing_and_job_scheduling_app/bin_packing/input_val_page.dart';
import 'package:flutter/material.dart';

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
        appBar: AppBar(
          title: Text("통 채우기"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                n = val;
              },
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (val) {
                c = val;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InputValPage(
                              objCnt: int.parse(n),
                              binSize: int.parse(c),
                            )),
                  );
                },
                child: Text("개수 입력 완료")),
          ],
        ));
  }
}
