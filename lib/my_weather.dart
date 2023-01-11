import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;

class MyWeather extends StatefulWidget {
  const MyWeather({super.key});

  @override
  State<MyWeather> createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  double icheonTemp = 0.0;

  void getDataFromWeb() async {
    http.Response respone =
        await http.get(Uri.parse('https://www.accuweather.com/ko/kr/icheon/223642/weather-forecast/223642'));

    dom.Document document = parse.parse(respone.body);

    final temp = document.getElementsByClassName('temp');
    print('m_temp: $temp');
    print('m_temp_value: ${temp[0].innerHtml}');

    final getData = temp
    .map((e) => e.getElementsByClassName('after-temp')[0].innerHtml)
    .toList();

    print('m_getData: $getData');

    String tempValue = temp[0].innerHtml.substring(0, temp[0].innerHtml.indexOf('°'));

    setState(() {
      icheonTemp = double.parse(tempValue);
    });

    print(icheonTemp); 
  }

  @override
  void initState() {
    super.initState();

    getDataFromWeb();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('[나의 응용]이천의 기온: $icheonTemp'));
  }
}