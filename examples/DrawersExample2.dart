import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Adaptive App',
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double colSpaceHeight = MediaQuery.of(context).size.height / 5;
    double colSpaceWidth = MediaQuery.of(context).size.width / 7;

    return Scaffold(
      appBar: AppBar(title: const Text("title")),
      body: const Center(
        child: Text('My Page!'),
      ),
      drawer: Container(
        width: colSpaceWidth,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  image: DecorationImage(
                    image: AssetImage("images/ph.png"),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
