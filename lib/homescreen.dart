import 'package:flutter/material.dart';
//import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'constants.dart' as k;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = false;
  num temp;
  num press;
  num hum;
  num cover;
  String cityname = '';
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xffFA8BFF),
                Color(0xff2BD2FF),
                Color(0xff2BFF88),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Visibility(
            visible: isLoaded,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.09,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        20,
                      ),
                    ),
                  ),
                  child: Center(
                    child: TextFormField(
                      onFieldSubmitted: (String s) {
                        setState(() {
                          cityname = s;
                          getCityWeather(s);
                          isLoaded = false;
                          controller.clear();
                        });
                      },
                      controller: controller,
                      cursorColor: Colors.white,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search city',
                        hintStyle: TextStyle(
                          fontSize: 18,
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ),
                        prefixIcon: Icon(
                          Icons.search_rounded,
                          size: 25,
                          color: Colors.white.withOpacity(0.7),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: Colors.red,
                        size: 40,
                      ),
                      Text(
                        cityname,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade900,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage('images/thermometer.png'),
                        width: MediaQuery.of(context).size.width * 0.09,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Temperature: ${temp?.toInt()} ºC',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade900,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage('images/barometer.png'),
                          width: MediaQuery.of(context).size.width * 0.09,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Pressure: ${press?.toInt()} hPa',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade900,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage('images/humidity.png'),
                          width: MediaQuery.of(context).size.width * 0.09,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Humidity: ${hum?.toInt()}%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.12,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade900,
                        offset: Offset(1, 2),
                        blurRadius: 3,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: AssetImage('images/cloud cover.png'),
                          width: MediaQuery.of(context).size.width * 0.09,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Cloud Cover: ${cover?.toInt()}%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            replacement: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        ),
      ),
    );
  }

  getCurrentLocation() async {
    var p = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true,
    );
    if (p != null) {
//      print('Lat:${p?.latitude}, Long:${p?.longitude}');
      getCurrentCityWeather(p);
    } else {
      print('Data unavailable');
    }
  }

  getCityWeather(String cityname) async {
    var client = http.Client();
    var uri = '${k.domain}q=$cityname&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodeData = json.decode(data);
//      print(data);
      updateUI(decodeData);
      setState(() {
        isLoaded = true;
      });
    } else {
      print(response.statusCode);
    }
  }

  getCurrentCityWeather(Position position) async {
    var client = http.Client();
    var uri =
        '${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodeData = json.decode(data);
      print(data);
      updateUI(decodeData);
      setState(() {
        isLoaded = true;
      });
    } else {
      print(response.statusCode);
    }
  }

  updateUI(var decodedData) {
    setState(() {
      if (decodedData == null) {
        temp = 0;
        press = 0;
        hum = 0;
        cover = 0;
        cityname = 'Not available';
      } else {
        temp = decodedData['main']['temp'] - 273;
        press = decodedData['main']['pressure'];
        hum = decodedData['main']['humidity'];
        cover = decodedData['clouds']['all'];
        cityname = decodedData['name'];
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }
}
