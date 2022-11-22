//import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:fl_chart/fl_chart.dart';

double currentTemp = 0;
//double currentNoise = 0;

//var noiseList = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.0];

var tempList = [0.0,0.0,0.0,0.0,0.0];
void readTempRecord() {
  for (int i=0; i<5; i++){
    String idx = i.toString();
    final userReference = FirebaseDatabase().reference().child("temprecord").child(idx);
    userReference.once().then((DataSnapshot dataSnapshot) {
      tempList[i] = dataSnapshot.value as double;
    });
  }
}
/*
void readNoiseRecord() {
  for (int i=0; i<10; i++){
    String idx = i.toString();
    final userReference = FirebaseDatabase().reference().child("noiserecord").child(idx);
    userReference.once().then((DataSnapshot dataSnapshot) {
      noiseList[i] = dataSnapshot.value as double;
    });
  }
}
*/
void readTemp() {
  final userReference = FirebaseDatabase().reference().child("temprecord").child("0");
  userReference.once().then((DataSnapshot dataSnapshot) {
    currentTemp = dataSnapshot.value;
  });
}
/*
void readNoise() {
  final userReference = FirebaseDatabase().reference().child("noiserecord").child("0");
  userReference.once().then((DataSnapshot dataSnapshot) {
    currentNoise = dataSnapshot.value;
  });
}

 */
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Baby Bed',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'text2',
      ),
      home: const MyHomePage(title: 'Smart Baby Bed'),
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
  int age = 22;

  String name = "Baby";

  void createData(String target, int data) {
    final userReference = FirebaseDatabase().reference().child(target);
    userReference.set({
      "0": data,
    });
  }

  void readData() {
    final userReference = FirebaseDatabase().reference();
    userReference.once().then((DataSnapshot dataSnapshot) {
      //int val = dataSnapshot.value;
    });
  }

  void deleteData() {
    final userReference = FirebaseDatabase().reference().child("user");
    userReference.remove();
  }

  void updateUI() {
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe0dbef),
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: const Color(0xffc4bee2),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          const Divider(
            height: 40.0,
            color: Colors.white,
            thickness: 2.0,
            endIndent: 30.0,
            indent: 30.0,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: const <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/baby.png'),
                      radius: 60.0,
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Baby",
                      style: TextStyle(
                        //fontFamily: 'text',
                        color: Color(0xff9986b3),
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.0,
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 30, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: (){
                        setState(() {
                          readTempRecord();
                          //readNoiseRecord();
                          readTemp();
                          //readNoise();
                        });
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                    const Text('나이',
                      style: TextStyle(
                        color: Color(0xff9986b3),
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text('$age 개월',
                    style: const TextStyle(
                      color: Color(0xff9986b3),
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                      fontSize: 28.0
                    ),
                    ),
                    const Text('체온',
                      style: TextStyle(
                        color: Color(0xff9986b3),
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('$currentTemp ℃',
                      style: const TextStyle(
                          color: Color(0xff9986b3),
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0
                      ),
                    ),
                    /*
                    const Text('소리',
                      style: TextStyle(
                        color: Color(0xff9986b3),
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('$currentNoise dB',
                      style: const TextStyle(
                          color: Color(0xff9986b3),
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                          fontSize: 28.0
                      ),
                    ),

                     */
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            height: 10.0,
            color: Colors.white,
            thickness: 2.0,
            endIndent: 30.0,
            indent: 30.0,
          ),
          const SizedBox(
            height: 0,
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 40,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30),
                    elevation: 0.0,
                    primary: const Color(0xffe0dbef),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SongPage(title: '노래')),
                    );
                    },
                    //child: const Text('song'),
                  child: Image.asset('assets/song_icon.png', scale: 3.0,),

                ),
              ),

              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30),
                    elevation: 0.0,
                    primary: const Color(0xffe0dbef),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RecordPage(title: '기록')),
                    );
                    },
                  //child: const Text('record'),
                  child: Image.asset('assets/record_icon.png', scale: 3.0,),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          ),
          const SizedBox(
            height: 0,
          ),
          Row(
            children: <Widget>[
              const SizedBox(
                width: 40,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30),
                    elevation: 0.0,
                    primary: const Color(0xffe0dbef),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyBedPage(title: '침대')),
                    );
                  },
                  //child: const Text('bed'),
                  child: Image.asset('assets/bed_icon.png', scale: 3.0,),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30),
                    elevation: 0.0,
                    primary: const Color(0xffe0dbef),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyMobilePage(title: '모빌')),
                    );
                  },
                  //child: const Text('mobile'),
                  child: Image.asset('assets/mobile_icon.png', scale: 3.0,),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key, required this.title}) : super(key :key);

  final String title;

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage>{

  List<Color> gradientColors = [
    const Color(0xff9986b3),
    const Color(0xff79619a),
  ];
  bool showAvg = false;

  void readTemp() {
    final userReference = FirebaseDatabase().reference().child("temprecord").child("0");
    userReference.once().then((DataSnapshot dataSnapshot) {
      currentTemp = dataSnapshot.value;
    });
  }
  /*
  void readNoise() {
    final userReference = FirebaseDatabase().reference().child("noise").child("0");
    userReference.once().then((DataSnapshot dataSnapshot) {
      currentNoise = dataSnapshot.value;
    });
  }

   */
  static const style = TextStyle(
    color: Color(0xff614e7b),
    letterSpacing: 2.0,
    fontWeight: FontWeight.bold,
    fontSize: 18,
    //fontFamily: 'text',
  );
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xffe0dbef),
      appBar: AppBar(
        title: const Text('체온 기록'),
        centerTitle: true,
        backgroundColor: const Color(0xffc4bee2),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          const Divider(
            height: 40.0,
            color: Colors.white,
            thickness: 2.0,
            endIndent: 30.0,
            indent: 30.0,
          ),
          const Text('최근 레포트',
          style: TextStyle(
            color: Color(0xff614e7b),
            letterSpacing: 2.0,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  readTemp();
                  readTempRecord();
                });
              },
              icon: const Icon(Icons.refresh)
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: const <Widget>[
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/baby.png'),
                      radius: 45,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Baby',
                      style: style,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        //const Text('온도 표시 사진'),
                        const SizedBox(
                          width: 10,
                        ),
                        Text('현재 온도: $currentTemp ℃',
                        style: style,
                        ),
                      ],
                    ),

                    Row(
                      children: const <Widget>[
                        //const Text('소음 표시 사진'),
                        SizedBox(
                          width: 10,
                        ),
                        /*
                        Text('현재 소음: $currentNoise dB',
                        style: style,
                        ),

                         */
                      ],
                    )

                  ],
                ),
              )
            ],
          ),

          const Divider(
            height: 30.0,
            color: Colors.white,
            thickness: 2.0,
            endIndent: 30.0,
            indent: 30.0,
          ),

          const Text('체온',
          style: style,
          ),
          const SizedBox(
            height: 10,
          ),
          AspectRatio(
            aspectRatio: 1.5,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                  color: Color(0xff232d37)),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: LineChart(
                  tempData(),
                ),
              ),
            ),
          ),
          /*
          const Divider(
            height: 30.0,
            color: Colors.white,
            thickness: 2.0,
            endIndent: 30.0,
            indent: 30.0,
          ),
          const Text('소음',
          style: style,
          ),
          AspectRatio(
            aspectRatio: 3.0,
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(18),
                  ),
                  color: Color(0xff232d37)),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 18.0, left: 12.0, top: 24, bottom: 12),
                child: LineChart(
                  noiseData(),
                ),
              ),
            ),
          ),

           */
        ],
      ),
    );
  }

  Widget tempBottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('3시간 전', style: style);
        break;
      case 2:
        text = const Text('2시간 전', style: style);
        break;
      case 3:
        text = const Text('1시간 전', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
  }

  Widget tempLeftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 30:
        text = '30 ℃';
        break;
      case 35:
        text = '35 ℃';
        break;
      case 40:
        text = '40 ℃';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }
  LineChartData tempData() {
  return LineChartData(
    gridData: FlGridData(
      show: true,
      drawVerticalLine: true,
      horizontalInterval: 5,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return FlLine(
          color: const Color(0xff37434d),
          strokeWidth: 1,
        );
      },
    ),
    //backgroundColor: const Color(),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: tempBottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTitlesWidget: tempLeftTitleWidgets,
          reservedSize: 40,
        ),
      ),
    ),
    borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d), width: 1)),
    minX: 0,
    maxX: 4,
    minY: 35,
    maxY: 40,
    lineBarsData: [
      LineChartBarData(
        spots: [
          FlSpot(0, tempList[0]),
          FlSpot(1, tempList[1]),
          FlSpot(2, tempList[2]),
          FlSpot(3, tempList[3]),
          FlSpot(4, tempList[4]),
        ],
        isCurved: true,
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          gradient: LinearGradient(
            colors: gradientColors
                .map((color) => color.withOpacity(0.3))
                .toList(),
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    ],
  );
  }
/*
  Widget noiseBottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff68737d),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('3시간 전', style: style);
        break;
      case 5:
        text = const Text('2시간 전', style: style);
        break;
      case 8:
        text = const Text('1시간 전', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return Padding(child: text, padding: const EdgeInsets.only(top: 8.0));
  }

  Widget noiseLeftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff67727d),
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 10:
        text = '10 dB';
        break;
      case 50:
        text = '50 dB';
        break;
      case 90:
        text = '90 dB';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData noiseData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: noiseBottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: noiseLeftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 9,
      minY: 0,
      maxY: 100,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, noiseList[0]),
            FlSpot(1, noiseList[1]),
            FlSpot(2, noiseList[2]),
            FlSpot(3, noiseList[3]),
            FlSpot(4, noiseList[4]),
            FlSpot(5, noiseList[5]),
            FlSpot(6, noiseList[6]),
            FlSpot(7, noiseList[7]),
            FlSpot(8, noiseList[8]),
            FlSpot(9, noiseList[9]),
          ],
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ],
    );
  }
  */
}

class SongPage extends StatefulWidget {
  const SongPage({Key? key, required this.title}) : super(key :key);

  final String title;

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage>{
  void createData(String target, int data) {
    final userReference = FirebaseDatabase().reference().child(target);
    userReference.set({
      "0": data,
    });
  }
  int songNum = 1;
  final List<bool> _selections = List.generate(2, (_) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffe0dbef),
        appBar: AppBar(
          title: const Text('노래'),
          centerTitle: true,
          backgroundColor: const Color(0xffc4bee2),
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/sing.png',
              scale : 2.5,
            ),
            const Divider(
              height: 40.0,
              color: Colors.white,
              thickness: 2.0,
              endIndent: 30.0,
              indent: 30.0,
            ),
            const Text('Select Song to Play',
                style: TextStyle(
                    color: Color(0xff9986b3),
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0
                ),
            ),
            const SizedBox(
              height: 10,
            ),
            NumberPicker(
                minValue: 1,
                maxValue: 10,
                value: songNum,
                //onChanged: (value) => setState(() => songNum = value),
                onChanged: (value) {
                  setState(() {
                    songNum = value;
                    createData("song", songNum);
                  });
                }
            ),
            const SizedBox(
              height: 20,
            ),
            ToggleButtons(
                children: const <Widget>[
                  Icon(Icons.play_arrow),
                  Icon(Icons.pause),
                ],
              isSelected: _selections,
                onPressed: (int index) {
                  setState((){
                    if(index == 0){
                      _selections[0] = true;
                      _selections[1] = false;
                      createData("songplay", 1);
                    }else {
                      _selections[0] = false;
                      _selections[1] = true;
                      createData("songplay", 0);
                    }
                  });
                },
            ),

          ],
        )
    );
  }
}

class MyMobilePage extends StatefulWidget{
  const MyMobilePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyMobilePage> createState() => _MyMobilePageState();
}

class _MyMobilePageState extends State<MyMobilePage> {
  int _currentPower = 0;
  int _currentTime = 0;
  void createData(int power, int time) {
    final userReference = FirebaseDatabase().reference().child("mobil");
    userReference.set({
      "Power": power,
      "Time": time,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe0dbef),
      appBar: AppBar(
        title: const Text('모빌 회전'),
        centerTitle: true,
        backgroundColor: const Color(0xffc4bee2),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/baby-crib.png',
            scale: 3,
          ),
          const Divider(
            height: 40.0,
            color: Colors.white,
            thickness: 2.0,
            endIndent: 30.0,
            indent: 30.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    const Text('Power'),
                    NumberPicker(
                      haptics: true,
                      value: _currentPower,
                      minValue: 0,
                      maxValue: 3,
                      onChanged: (value) {
                        setState(() {
                          _currentPower = value;
                          createData(_currentPower, _currentTime);
                        });
                      },
                    ),
                    //Text('Current value: $_currentPower'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    const Text('Time'),
                    NumberPicker(

                      value: _currentTime,
                      minValue: 0,
                      maxValue: 3,

                      onChanged: (value) {
                        setState(() {
                          _currentTime = value;
                          createData(_currentPower, _currentTime);
                        });
                      },
                    ),
                    //Text('Current value: $_currentTime'),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 40.0,
            color: Colors.white,
            thickness: 2.0,
            endIndent: 30.0,
            indent: 30.0,
          ),
          const Text('Preset'),
          const SizedBox(
            height: 20,
          ),
          Row (
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30),
                    elevation: 0.0,
                    primary: const Color(0xff9986b3),
                  ),
                  onPressed: (){
                    setState(() {
                      _currentPower = 1;
                      _currentTime = 1;
                      createData(_currentPower, _currentTime);
                    });
                  },
                  child: const Text('1'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30),
                    elevation: 0.0,
                    primary: const Color(0xff9986b3),
                  ),
                  onPressed: (){
                    setState(() {
                      _currentPower = 2;
                      _currentTime = 2;
                      createData(_currentPower, _currentTime);
                    });
                  },
                  child: const Text('2'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30),
                    elevation: 0.0,
                    primary: const Color(0xff9986b3),
                  ),
                  onPressed: (){
                    setState(() {
                      _currentPower = 3;
                      _currentTime = 3;
                      createData(_currentPower, _currentTime);
                    });
                  },
                  child: const Text('3'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}


class MyBedPage extends StatefulWidget {
  const MyBedPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyBedPage> createState() => _MyBedPageState();
}

class _MyBedPageState extends State<MyBedPage> {
  int _currentPower = 0;
  int _currentTime = 0;
  void createData(int power, int time) {
    final userReference = FirebaseDatabase().reference().child("bed");
    userReference.set({
      "Power": power,
      "Time": time,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffe0dbef),
      appBar: AppBar(
        title: const Text('침대 흔들기'),
        centerTitle: true,
        backgroundColor: const Color(0xffc4bee2),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          Image.asset(
            'assets/cot.png',
            scale: 3,
          ),
          const Divider(
            height: 40.0,
            color: Colors.white,
            thickness: 2.0,
            endIndent: 30.0,
            indent: 30.0,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    const Text('Power'),
                    NumberPicker(
                      haptics: true,
                      value: _currentPower,
                      minValue: 0,
                      maxValue: 3,
                      onChanged: (value) {
                        setState(() {
                          _currentPower = value;
                          createData(_currentPower, _currentTime);
                        });
                      },
                    ),
                    //Text('Current value: $_currentPower'),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    const Text('Time'),
                    NumberPicker(

                      value: _currentTime,
                      minValue: 0,
                      maxValue: 3,

                      onChanged: (value) {
                        setState(() {
                          _currentTime = value;
                          createData(_currentPower, _currentTime);
                        });
                      },
                    ),
                    //Text('Current value: $_currentTime'),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            height: 40.0,
            color: Colors.white,
            thickness: 2.0,
            endIndent: 30.0,
            indent: 30.0,
          ),
          const Text('Preset'),
          const SizedBox(
            height: 20,
          ),
          Row (
            children: <Widget>[
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30),
                    elevation: 0.0,
                    primary: const Color(0xff9986b3),
                  ),
                  onPressed: (){
                    setState(() {
                      _currentPower = 1;
                      _currentTime = 1;
                      createData(_currentPower, _currentTime);
                    });
                    },
                  child: const Text('1'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30),
                    elevation: 0.0,
                    primary: const Color(0xff9986b3),
                  ),
                  onPressed: (){
                    setState(() {
                      _currentPower = 2;
                      _currentTime = 2;
                      createData(_currentPower, _currentTime);
                    });
                  },
                  child: const Text('2'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(30),
                    elevation: 0.0,
                    primary: const Color(0xff9986b3),
                  ),
                  onPressed: (){
                    setState(() {
                      _currentPower = 3;
                      _currentTime = 3;
                      createData(_currentPower, _currentTime);
                    });
                  },
                  child: const Text('3'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
