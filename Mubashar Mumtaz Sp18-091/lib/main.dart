import 'dart:math';
import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int randomnumber = 0;

  int randomNumber(){
    int random = Random().nextInt(10)+1; //1000 is MAX value
    //generate random number below 1000
    return random;
  }


  List<Text> textList=[];


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.grey,
        floatingActionButton:FloatingActionButton(child: Icon(Icons.reset_tv),onPressed: (){textList.clear() ;randomnumber=0;setState(() {

        });}),
        appBar: AppBar(
          title: Text("Random Number Table (Quiz) by Sir ABDULLAH"),
          backgroundColor: Colors.black,
        ),
        body: Container(
            height:250,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                      onPressed: (){
                        setState(() {
                          randomnumber = randomNumber();
                          textList.clear();
                          for(int i=1;i<=10;i++){
                            textList.add(Text("${randomnumber} * ${i} = ${randomnumber* i}"));
                          }
                          //call random number generate function
                        });
                      },
                      child: Text("Random Numbers: $randomnumber")

                  ),
                ),
                SizedBox(height: 30,),
                Expanded(
                  child: Card(color: Colors.red ,
                    child: SizedBox(
                        child: (textList.isNotEmpty)?Column(
                          children: [
                            textList[0],
                            textList[1],
                            textList[2],
                            textList[3],
                            textList[4],
                            textList[5],
                            textList[6],
                            textList[7],
                            textList[8],
                            textList[9],



                          ],
                        ):SizedBox (
                            width: 100,
                            child: Text(" "))
                    ),
                  ),
                ),



              ],
            )

        )

    );
  }
}