import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:popcat/models/counter_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum SoundType { pop, woop, coin }

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  static const title = 'SP18-BCS-091/Counter';
  static const decreaseButtonLabel = 'COUNT DOWN';
  static const resetButtonLabel = 'RESET';
  static const resetDialogTitle = 'RESET COUNTER';
  static const resetDialogText = 'Are you sure?';
  static const resetDialogOk = 'OK';
  static const resetDialogCancel = 'CANCEL';
  static const titleFontSize = 70.0;
  static const lowerNumberFontSize = 100.0;
  static const upperNumberFontSize = 120.0;

  var _isPop = false;
  Counter? _counter;

  late Animation<double> _animation;
  late AnimationController _controller;
  static AudioCache audioCache = AudioCache();

  static const soundAssetPath = 'assetPath';
  static const soundData = 'data';

  Map<SoundType, Map<String, dynamic>> _soundMap = {
    SoundType.pop: {
      soundAssetPath: 'sounds/pop2.mp3',
      soundData: null,
    },
    SoundType.woop: {
      soundAssetPath: 'sounds/woop_out.mp3',
      soundData: null,
    },
    SoundType.coin: {
      soundAssetPath: 'sounds/coin.wav',
      soundData: null,
    },
  };

  @override
  void initState() {
    super.initState();

    Counter.createFromPref().then((counter) {
      setState(() {
        _counter = counter;
      });
    });

    _soundMap.forEach(
      (k, v) => _loadSoundFile(v[soundAssetPath]!, (bytes) {
        v[soundData] = bytes;
      }),
    );

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 60),
    );

    _animation = Tween<double>(
      begin: lowerNumberFontSize,
      end: upperNumberFontSize,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // background layer
          Transform.scale(
            scale: 1.1,
            child: Transform.rotate(
              angle: -0.0523599, // 3 degrees
              child: Container(
                decoration: const BoxDecoration(
                  image: const DecorationImage(
                    image: const AssetImage("assets/images/bg.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
          // title, counter, and cat image layer
          if (_counter != null)
            SafeArea(
              child: Column(
                children: [
                  _buildText(title, titleFontSize, 2.0),
                  _buildCounter(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        _isPop
                            ? "assets/images/op.webp"
                            : "assets/images/p.webp",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          // gesture detector and buttons layer
          if (_counter != null)
            Column(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTapDown: (_) {
                      _playSound(SoundType.pop);
                      setState(() {
                        _counter!.updateValue(1);
                        _isPop = true;
                        _controller.forward();
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        _isPop = false;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        _isPop = false;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildButton(decreaseButtonLabel, () {
                        _playSound(SoundType.woop, volume: 0.2);
                        setState(() {
                          _counter!.updateValue(-1);
                          _controller.forward();
                        });
                      }),
                      _buildButton(resetButtonLabel, () {
                        _showResetDialog();
                      }),
                    ],
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }

  Widget _buildCounter() {
    return RotationTransition(
      turns: Tween(
        begin: 0.0,
        // random angle including sign (+/-)
        end: (Random().nextInt(2) == 0 ? 1 : -1) * Random().nextDouble() * 0.05,
      ).animate(_controller),
      child: _buildText(
        _counter!.value.toString(),
        // animate font size from lowerNumberFontSize to upperNumberFontSize
        _animation.value,
        // animate font stroke width from 2.0 to 4.0 based on font size
        2.0 +
            2.0 *
                (_animation.value - lowerNumberFontSize) /
                (upperNumberFontSize - lowerNumberFontSize),
      ),
    );
  }

  Widget _buildText(String text, double fontSize, double strokeWidth) {
    return Stack(
      children: [
        Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        Text(
          text,
          style: GoogleFonts.nunito(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String label, Function onClick) {
    return TextButton(
      onPressed: () {
        onClick();
      },
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        //minimumSize: Size(50, 30),
      ),
      child: Text(
        label,
        style: GoogleFonts.nunito(
          fontSize: 20.0,
          color: Colors.white,
        ),
      ),
    );
  }

  void _loadSoundFile(
    String filePath,
    Function(Uint8List?) callback,
  ) async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var sdkInt = androidInfo.version.sdkInt;
      if (sdkInt <= 22) {
        callback(null);
        return;
      }
    }

    audioCache.loadAsFile(filePath).then((file) {
      file.readAsBytes().then((bytes) {
        print('Load sound data successfully!');
        callback(bytes);
      }).catchError((e) {
        print('ERROR reading sound data from file: $filePath');
        callback(null);
      });
    }).catchError((e) {
      print('ERROR loading asset sound file: $filePath');
      callback(null);
    });
  }

  void _playSound(SoundType soundType, {double volume = 1.0}) {
    Map<String, dynamic> sound = _soundMap[soundType]!;
    if (sound[soundData] != null) {
      print('Playing sound from bytes data');
      audioCache.playBytes(sound[soundData], volume: volume);
    } else {
      print('Playing sound from asset file');
      audioCache.play(sound[soundAssetPath], volume: volume);
    }
  }

  Future<void> _showResetDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(resetDialogTitle),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(resetDialogText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(resetDialogCancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(resetDialogOk),
              onPressed: () {
                _playSound(SoundType.coin, volume: 0.2);
                setState(() {
                  _counter!.resetValue();
                  _controller.forward();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
