// ignore_for_file: library_private_types_in_public_api, unused_element

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:intl/intl.dart';
import '../backend/api_bridge.dart';
import '../common/myWidgets/labels.dart';
import '../defaul_config.dart';
import '';

class Dashboard extends StatefulWidget {
  final double contextHeight;
  final double contextWidth;
  const Dashboard({
    Key? key,
    required this.contextHeight,
    required this.contextWidth,
  }) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  double currentMonthPercentage = 0.0;
  @override
  void initState() {
    super.initState();
    _getChangesPercentageForCurrentMonth().then((value) {
      setState(() {
        currentMonthPercentage = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(4),
              bottomRight: Radius.circular(4),
            ),
          ),
          child: const FittedBox(
            fit: BoxFit.scaleDown,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "DASHBOARD",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 40.0,
        ),
        FutureBuilder<List<Map<String, dynamic>>>(
          future: _getProjectChanges(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<Map<String, dynamic>> projectChanges = snapshot.data ?? [];
                return Card(
                  elevation: 2,
                  child: Column(
                    children: [
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxHeight: double.infinity),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Wrap(
                              direction: Axis.horizontal,
                              spacing: 8.0,
                              runSpacing: 4.0,
                              alignment: WrapAlignment.spaceEvenly,
                              children: projectChanges
                                  .map(
                                    (project) => Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Text(project["name"]),
                                        ),
                                        const SizedBox(height: 5),
                                        Container(
                                          height: 100,
                                          width: 45,
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 240, 240, 240),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: project["changes"]
                                                      .toDouble() *
                                                  2,
                                              width: 51,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 190, 3, 3),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(project["changes"].toString(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold))
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(4),
                            bottomRight: Radius.circular(4),
                          ),
                        ),
                        child: const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "CANTIDAD DE CAMBIOS TOTALES POR PROYECTO",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
       const  SizedBox(height: 30.0),
        Card(
          elevation: 2,
          child: SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 120,
                            width: 120,
                            child: CircularProgressIndicator(
                              value: currentMonthPercentage / 100,
                              backgroundColor: Colors.grey[300],
                              strokeWidth: 10,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.red),
                            ),
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${currentMonthPercentage.toStringAsFixed(0)}%",
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.book,
                          size: 50,
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "CAMBIOS DEL MES",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ])),
    );
  }
}

class ProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color color;
  final Color backgroundColor;

  ProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = (size.width - strokeWidth) / 2;
    canvas.drawCircle(center, radius, paint);

    paint.color = color;
    double arcAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      arcAngle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(ProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}

Future<List<Map<String, dynamic>>> _getProjectChanges() async {
  var results = await spData(sp: "get_actividades");
  List<Map<String, dynamic>> projectChanges = [];

  // Este mapa almacenará los cambios de cada proyecto
  Map<String, int> changesByProject = {};

  if (results[scc]) {
    Map<String, dynamic> myContent = results[cnt];
    for (var key1 in myContent.keys) {
      var value = myContent[key1];
      if (value["ESTADO"] == '0') {
        continue;
      }
      String projectName = value['FK_PROYECTO'].toString();

      if (changesByProject.containsKey(projectName)) {
        changesByProject[projectName] = changesByProject[projectName]! + 1;
      } else {
        changesByProject[projectName] = 1;
      }
    }

    for (var entry in changesByProject.entries) {
      projectChanges.add({
        'name': entry.key,
        'changes': entry.value,
      });
    }
  } else {
    print("No se logró pa");
  }
  return projectChanges;
}

Future<double> _getChangesPercentageForCurrentMonth() async {
  var results = await spData(sp: "get_actividades");
  int currentMonthChanges = 0;
  DateTime now = DateTime.now();
  int currentMonth = now.month;
  int currentYear = now.year;

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  if (results[scc]) {
    Map<String, dynamic> myContent = results[cnt];
    for (var key1 in myContent.keys) {
      var value = myContent[key1];
      if (value["ESTADO"] == '0') {
        continue;
      }
      DateTime activityDate;
      try {
        activityDate = dateFormat.parse(value['FECHA'].toString());
      } catch (e) {
        print("Error al analizar la fecha: $e");
        print(value['FECHA'].toString());
        continue;
      }

      if (activityDate.month == currentMonth &&
          activityDate.year == currentYear) {
        currentMonthChanges += 1;
      }
    }
  } else {
    print("No se logró pa");
  }

  int daysInCurrentMonth = DateTime(now.year, now.month + 1, 0).day;
  int daysRemaining = daysInCurrentMonth - now.day;

  return (currentMonthChanges / daysRemaining) * 100;
}
