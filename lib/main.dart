import 'package:flutter/material.dart';
import 'package:sohel_nuts/page/almond.dart';
import 'package:sohel_nuts/page/cashew.dart';
import 'package:sohel_nuts/page/cassia.dart';
import 'package:sohel_nuts/page/home.dart';
import 'package:sohel_nuts/page/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sohel_nuts/page/test.dart';
import 'package:sohel_nuts/page/type.dart';

void main() {
  runApp(
      MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.pink, // Your app THEME-COLOR
        ),
        debugShowCheckedModeBanner: false,
        home: MyHomePage(),
      ));
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 3),() async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? 0;

      if(token == 0)
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context) => Cashew()));
        //Navigator.push(context, MaterialPageRoute(builder: (context) => TypeTest()));
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  Scaffold(
        body: DecoratedBox(
          decoration: new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage('images/logo.jpg'),
                fit: BoxFit.fill
            ),
          ),
        ),
      ),

    );
  }

}
