import 'package:flutter/material.dart';
import 'package:web_page/my_weather.dart';
import 'package:web_page/weather.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('web_page'),
      ),
      body: Row(

        children: [
          Expanded(child: Weather()),
          Padding(padding: EdgeInsets.all(10)),
          Expanded(child: MyWeather(),),
        ],
      ),
    );
  }
}
