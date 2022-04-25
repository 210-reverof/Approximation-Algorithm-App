import 'package:bin_packing_and_job_scheduling_app/bin_packing/input_n_page.dart';
import 'package:bin_packing_and_job_scheduling_app/job_scheduling/input_schedule_n_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          child: Image.asset("assets/background_main.png"),
        ),
        Center(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              const Text(
                "AAA             ",
                style: TextStyle(
                    fontSize: 50,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const Text(
                "Approximation Algorithm App",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 118, 230, 182),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              getButtonBox(InputNPage(), "assets/icon_bin.png", "통 채우기"),
              const SizedBox(
                height: 30,
              ),
              getButtonBox(
                  InputScheduleNPage(), "assets/icon_job.png", "작업 스케줄링"),
            ],
          ),
        ),
      ],
    ));
  }

  Widget getButtonBox(Page, String imgDir, String str) {
    return Container(
      width: 320,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
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
          const SizedBox(
            height: 25,
          ),
          Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Container(width: 60, height: 60, child: Image.asset(imgDir)),
              SizedBox(
                width: 10,
              ),
              Container(
                  width: 200,
                  height: 60,
                  child: Text(str == "통 채우기"
                      ? "n개의 물건이 주어지고, 통(bin)의 용량이 C일 때, 주어진 모든 물건을 가장 적은 수의 통에 채우는 문제"
                      : "n개의 작업, 시간, 기계가 주어질 때, 가장 빨리 종료되도록 작업을 기계에 배정하는 문제")),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Page),
              );
            },
            child: Text(str + " 알고리즘 활용하기",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              primary:
                  Color.fromARGB(255, 95, 197, 153), // This is what you need!
            ),
          )
        ],
      ),
    );
  }
}
