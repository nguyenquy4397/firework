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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FireworksHaveRocket(
        controller: _controller,
        fireworksNumber: 4,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: List.generate(
                    20,
                    (index) => const ListTile(
                            title: Text(
                          'longgggggggggggggggggggggggggggggggggg',
                          style: TextStyle(color: Colors.black),
                        ))),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    _controller.play();
                  },
                  icon: const Icon(
                    Icons.launch,
                    color: Colors.black,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _noRocketController.play();
                  },
                  icon: const Icon(Icons.stream),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
