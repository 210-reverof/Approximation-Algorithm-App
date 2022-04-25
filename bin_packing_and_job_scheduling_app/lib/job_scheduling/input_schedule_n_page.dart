import 'package:bin_packing_and_job_scheduling_app/job_scheduling/input_val_page.dart';
import 'package:flutter/material.dart';

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
        appBar: AppBar(
          title: Text("작업 스케줄링 문제"),
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
                              machineCnt: int.parse(c),
                            )),
                  );
                },
                child: Text("개수 입력 완료")),
          ],
        ));
  }
}
