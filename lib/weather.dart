import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parse;


class Weather extends StatefulWidget {
  const Weather({super.key});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  var weather = <String>[];
  var currentTemp = '';

  void _getDataFromWeb() async {
    final respone = await http.get(Uri.parse(
      'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=1&ie=utf8&query=군포시+날씨'
    ));

    // 네트워크 요청으로 DOM Parser를 읽어온다.
    dom.Document document = parse.parse(respone.body);

    setState(() {
      //DOM Parser를 읽어왔을 때, 이 중에서 <div>태그의 class이름을 특정지어서 찾는 것이다.
      List<dom.Element> temp = document.getElementsByClassName('temperature_text');
      // print('temp: $temp');
      weather = temp
      // 해당 클래스 안에서 태그(p, span, h1...)이름으로 리스트를 만들어 불러올 수 있다. 
      // 여기서 innerHtml옵션은 Html 자체를 그대로 가져온다.
      .map((e) => e.getElementsByTagName('strong')[0].innerHtml)
      .toList();

      print('weather: $weather');
      currentTemp = weather[0].replaceAll(RegExp('[^0-9]'), '');
    });
  }

  @override
  void initState() {
    super.initState();

    _getDataFromWeb();
  }

  @override
  Widget build(BuildContext context) {
    return Text('[예제]현재 기온은 $currentTemp도 입니다.');
  }
}