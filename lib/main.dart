import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  Future getWeather() async{
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Tallinn&appid=766ee2fbd971d8020d0b15315e883e32&units=metric"));
 var results =jsonDecode(response.body);

 setState(() {
   temp = results['main']['temp'];
   description = results['weather'][0]['description'];
   currently = results['weather'][0]['main'];
   humidity = results['main']['humidity'];
   windSpeed = results['wind']['speed'];
 });
  }
  @override
  void initState(){
    super.initState();
    getWeather();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: const Text("THE WEATHER APP"),
        backgroundColor: Colors.black54,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.black87,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  <Widget>[
                const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Currently in Tallinn",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  temp != null ? "$temp\u00B0" : "Loading",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView(
                  children:  <Widget>[
                    ListTile(
                leading: const FaIcon(FontAwesomeIcons.temperatureHalf),
                      title: const Text("Temperature"),
                      trailing: Text(temp != null ? "$temp\u00B0" : "Loading"),
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.cloud),
                      title: const Text("Weather"),
                      trailing: Text(description != null ? "$description\u00B0" : "Loading"),
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.sun),
                      title: const Text("Humidity"),
                      trailing: Text(humidity != null ? "$humidity\u00B0" : "Loading"),
                    ),
                    ListTile(
                      leading: const FaIcon(FontAwesomeIcons.wind),
                      title: const Text("Winds peed"),
                      trailing: Text(windSpeed != null ? "$windSpeed\u00B0" : "Loading"),
                    ),
                  ],
                ),
              )
          )
        ],
      ),
    );
  }
}
