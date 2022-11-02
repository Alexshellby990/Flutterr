// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'calculation.dart';

class ResultPage extends StatefulWidget {
  int height;
  int weight;
  int age;
  // ignore: use_key_in_widget_constructors
  ResultPage({required this.height, required this.weight, required this.age});

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  double bmires = 0;
  //int bmiAge = Age;
  void initState() {
    Logic l = Logic();
    bmires = l.calculateBMI(widget.height, widget.weight);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "BMI Calculator",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "BMI RESULT IS :",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                '${bmires.toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              Text(
                "YOUR AGE IS :",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                '${widget.age}',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
