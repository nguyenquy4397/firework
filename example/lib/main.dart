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

class _MyHomePageState extends State<MyHomePage> {
  final _controller = FireworksHaveRocketController();
  final _noRocketController = FireworksNoRocketController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FireworksHaveRocket(
        controller: _controller,
        fireworksNumber: 4,
        child: FireworksNoRocket(
            controller: _noRocketController,
            fireworksNumber: 4,
            child: Center(child: Image.asset('assets/congratulation.png'))),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              _controller.play();
            },
            child: const Icon(Icons.launch),
          ),
          FloatingActionButton(
            onPressed: () {
              _noRocketController.play();
            },
            child: const Icon(Icons.stream),
          ),
        ],
      ),
    );
  }
}
