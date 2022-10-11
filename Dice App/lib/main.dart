import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

void main() {
  return runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/second': (context) => Page2players(),
        '/third': (context) => Page4players(),
      },
    ),
  );
}

void playsound(int n) {
  final play = AudioCache();
  play.play('sound$n.wav');
}

var leftDiceNumber = 1;
var rightDiceNumber = 1;
var leftdDiceNumber = 1;
var rightdDiceNumber = 1;

int player1 = 0,
    player2 = 0,
    player3 = 0,
    player4 = 0,
    count1 = 0,
    count2 = 0,
    count3 = 0,
    winner = 0,
    count4 = 0;

double height4 = 130.0, width4 = 230.0;

void AlertResult2(BuildContext context) {
  if (player1 > player2) {
    winner = 1;
    showAlertDialog5(context);
  } else if (player2 > player1) {
    winner = 2;
    showAlertDialog5(context);
  }
}

void AlertResult(BuildContext context) {
  if (player1 > player2 && player1 > player3 && player1 > count4) {
    winner = 1;
    showAlertDialog5(context);
  } else if (player2 > player1 && player2 > count3 && player2 > player4) {
    winner = 2;
    showAlertDialog5(context);
  } else if (player3 > player2 && player3 > player1 && player3 > player4) {
    winner = 3;
    showAlertDialog5(context);
  } else if (player4 > player2 && player4 > player1 && player4 > player3) {
    winner = 4;
    showAlertDialog5(context);
  }
}

void reset() {
  leftDiceNumber = 1;
  rightDiceNumber = 1;
  leftdDiceNumber = 1;
  rightdDiceNumber = 1;
  player1 = player2 = player3 = player4 = count1 = count2 = count3 = count4 = 0;
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text(
            'D I C E (GAME)',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.purple, Colors.blue],
              ),
            ),
          ),
        ),
        body: Center(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  minWidth: 70.0,
                  height: 70.0,
                  onPressed: () {
                    Navigator.pushNamed(context, '/second');
                  },
                  child: Text(
                    "2 Players",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.orange,
                ),
                SizedBox(
                  height: 50.0,
                ),
                FlatButton(
                  minWidth: 70.0,
                  height: 70.0,
                  onPressed: () {
                    Navigator.pushNamed(context, '/third');
                  },
                  child: Text(
                    "4 Players",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  color: Colors.orange,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Page4players extends StatefulWidget {
  @override
  _Page4playersState createState() => _Page4playersState();
}

class _Page4playersState extends State<Page4players> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text(
            '4 Players',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              reset();
              Navigator.pushNamed(context, '/');
            },
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.purple, Colors.blue],
              ),
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Text(
                'Total Dice Clicks For Each Players = 10',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  '                  Player1',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '                  Score:$player1',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '                     Dice Clicks:$count1',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    if (count1 == 10 &&
                                        count2 == 10 &&
                                        count3 == 10 &&
                                        count4 == 10) {
                                      AlertResult(context);
                                    }
                                    setState(() {
                                      if (count1 < 10) {
                                        playsound(1);
                                        count1++;

                                        leftDiceNumber =
                                            Random().nextInt(6) + 1;
                                        player1 = player1 + leftDiceNumber;
                                      } else if (count1 == 10) {
                                        showAlertDialog(context);
                                      }
                                    });
                                  },
                                  child: Image.asset(
                                    'images/dice$leftDiceNumber.png',
                                    height: height4,
                                    width: width4,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                    Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  '                  Player2',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '                  Score:$player2',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '                     Dice Clicks:$count2',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    if (count1 == 10 &&
                                        count2 == 10 &&
                                        count3 == 10 &&
                                        count4 == 10) {
                                      AlertResult(context);
                                    }
                                    setState(() {
                                      if (count2 < 10) {
                                        playsound(1);
                                        count2++;
                                        rightDiceNumber =
                                            Random().nextInt(6) + 1;
                                        player2 = player2 + rightDiceNumber;
                                      } else if (count2 == 10) {
                                        showAlertDialog2(context);
                                      }
                                    });
                                  },
                                  child: Image.asset(
                                    'images/dice$rightDiceNumber.png',
                                    height: height4,
                                    width: width4,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                    Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  '                  Player3',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '                  Score:$player3',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '                     Dice Clicks:$count3',
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    if (count1 == 10 &&
                                        count2 == 10 &&
                                        count3 == 10 &&
                                        count4 == 10) {
                                      AlertResult(context);
                                    }
                                    setState(() {
                                      if (count3 < 10) {
                                        playsound(1);
                                        count3++;
                                        leftdDiceNumber =
                                            Random().nextInt(6) + 1;
                                        player3 = player3 + leftdDiceNumber;
                                      } else if (count3 == 10) {
                                        showAlertDialog3(context);
                                      }
                                    });
                                  },
                                  child: Image.asset(
                                    'images/dice$leftdDiceNumber.png',
                                    height: height4,
                                    width: width4,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                    Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  '                  Player4',
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '                  Score:$player4',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '                     Dice Clicks:$count4',
                                  style: TextStyle(
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    if (count1 == 10 &&
                                        count2 == 10 &&
                                        count3 == 10 &&
                                        count4 == 10) {
                                      AlertResult(context);
                                    }
                                    setState(() {
                                      if (count4 < 10) {
                                        playsound(1);
                                        count4++;
                                        rightdDiceNumber =
                                            Random().nextInt(6) + 1;
                                        player4 = player4 + rightDiceNumber;
                                      } else if (count4 == 10) {
                                        showAlertDialog4(context);
                                      }
                                    });
                                  },
                                  child: Image.asset(
                                    'images/dice$rightdDiceNumber.png',
                                    height: height4,
                                    width: width4,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.refresh),
                      iconSize: 40.0,
                      color: Colors.white,
                      hoverColor: Colors.red,
                      onPressed: () {
                        setState(() {
                          playsound(2);
                          reset();
                        });
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Page2players extends StatefulWidget {
  @override
  _Page2playersState createState() => _Page2playersState();
}

class _Page2playersState extends State<Page2players> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.red,
          title: Text(
            '2 Players',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              reset();
              Navigator.pushNamed(context, '/');
            },
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Colors.purple, Colors.blue],
              ),
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Text(
                'Total Dice Clicks For Both Players = 10',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 20.0,
                ),
              ),
              SizedBox(
                height: 100.0,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  '             Player1',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '             Score:$player1',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '               Dice Clicks:$count1',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    if (count1 == 10 && count2 == 10) {
                                      AlertResult2(context);
                                    }
                                    setState(() {
                                      if (count1 < 10) {
                                        playsound(1);
                                        count1++;
                                        leftDiceNumber =
                                            Random().nextInt(6) + 1;
                                        player1 = player1 + leftDiceNumber;
                                      } else if (count1 == 10) {
                                        showAlertDialog(context);
                                      }
                                    });
                                  },
                                  child: Image.asset(
                                    'images/dice$leftDiceNumber.png',
                                    height: 180.0,
                                    width: 200.0,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                    Container(
                        color: Colors.black,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  '             Player2',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '             Score:$player2',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '               Dice Clicks:$count2',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: () {
                                    if (count1 == 10 && count2 == 10) {
                                      AlertResult2(context);
                                    }
                                    setState(() {
                                      playsound(1);
                                      if (count2 < 10) {
                                        count2++;
                                        rightDiceNumber =
                                            Random().nextInt(6) + 1;
                                        player2 = player2 + rightDiceNumber;
                                      } else if (count2 == 10) {
                                        showAlertDialog2(context);
                                      }
                                    });
                                  },
                                  child: Image.asset(
                                    'images/dice$rightDiceNumber.png',
                                    height: 180.0,
                                    width: 200.0,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: IconButton(
                      icon: Icon(Icons.refresh),
                      iconSize: 40.0,
                      color: Colors.white,
                      hoverColor: Colors.red,
                      onPressed: () {
                        setState(() {
                          playsound(2);
                          reset();
                        });
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("No More Dice Clicks Left"),
    content: Text("Player 1 (Completed All Dice Clicks)"),
    actions: [okButton],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext) {
      return alert;
    },
  );
}

showAlertDialog2(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("No More Dice Clicks Left"),
    content: Text("Player 2 (Completed All Dice Clicks)"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog3(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("No More Dice Clicks Left"),
    content: Text("Player 3 (Completed All Dice Clicks)"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog4(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("No More Dice Clicks Left"),
    content: Text("Player 4 (Completed All Dice Clicks)"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog5(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Congratulations"),
    content: Text("Player$winner is the Winner "),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
