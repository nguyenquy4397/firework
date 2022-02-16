import 'dart:math';

import 'package:firework/firework.dart';
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
      title: 'Fireworks Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Fireworks'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late final FireworkController _controller = FireworkController(
    vsync: this,
    radius: 70,
  )
    ..start()
    ..autoLaunchDuration = Duration.zero
    ..rocketSpawnTimeout = Duration.zero;
  final _random = Random();

  void _incrementCounter() {
    _controller.spawnRocket(
      const Point(100, 100),
      forceSpawn: true,
    );
    _controller.spawnRocket(
      Point(_controller.windowSize.width - 10,
          _controller.windowSize.width / 2 - 25),
      forceSpawn: true,
    );
    _controller.spawnRocket(
      Point(50, _controller.windowSize.height / 2),
      forceSpawn: true,
    );
    _controller.spawnRocket(
      Point(_controller.windowSize.width / 2,
          3 * _controller.windowSize.height / 4),
      forceSpawn: true,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Fireworks(
            controller: _controller,
          ),
          Center(
            child: Image.asset('assets/congratulation.png'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: const Icon(Icons.launch),
      ),
    );
  }
}
