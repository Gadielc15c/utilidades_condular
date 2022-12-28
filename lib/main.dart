import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String buttonName = 'Un boton';
  int unNumero = 0;

  void test(int index) {
    setState(() {
      unNumero = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("ok"),
        ),
        body: Center(
          child: unNumero == 0
              ? Container(
                  color: Colors.yellow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text("Contenido"),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            buttonName = "Cambio el texto";
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.orangeAccent,
                          backgroundColor: Colors.black,
                        ),
                        child: Text(buttonName),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: unNumero,
          onTap: test,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home,
                color: Colors.purple,
                size: 50,
                semanticLabel: 'Text for accessibility mode? ok',
              ),
            ),
            BottomNavigationBarItem(
              label: 'Persona Invalida',
              icon: Icon(
                Icons.wheelchair_pickup,
                color: Colors.green,
                size: 200,
                semanticLabel: 'Text for accessibility mode? ok',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
