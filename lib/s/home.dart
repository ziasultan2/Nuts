import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sohel_nuts/network/network.dart';
import 'package:sohel_nuts/page/almond.dart';
import 'package:sohel_nuts/page/cassia.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cashew.dart';
import 'login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List data=[];

  Future<String> _getNuts() async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    var res = await http.get(
      Network.nuts_name,
        headers: {"Accept": "application/json", "Authorization": token});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });
    print(resBody);
  }

  @override
  void initState() {
    super.initState();
    this._getNuts();
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Text('HOME'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.power_settings_new, size: 30,),
              onPressed: () {
                _showDialog();
              },
            ),
          ],

        ),
        body:
            Container(
              margin: EdgeInsets.all(15.0),
              child:ListView.builder(
                itemCount: data == null ? 0 : data.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 15.0, top: 15.0),
                    child:Container(
                      child:

                      ListTile(
                        title: Text(data[index], style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,),),
                        trailing: Container(
                          child: Icon(Icons.arrow_forward_ios, size: 25.0,),
                        ),
                        onTap: (){
                          var item = data.indexOf(data[index]);
                          switch(item)
                          {
                            case 0:
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Almond()));
                              return;
                            case 1:
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Cassia()));
                              return;
                            case 2:
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Cashew()));

                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            
        ),
      );
  }



  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          contentPadding: EdgeInsets.all(50.0),
          title: Text('WARNING', style: TextStyle(fontSize: 50.0, color: Colors.red), textAlign: TextAlign.center,),
          content: new Text("Are You Sure You Want To Exit?", style: TextStyle(fontSize :30.0, color: Colors.orange), textAlign: TextAlign.center,),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Yes", textAlign: TextAlign.center,),
              onPressed: () async{
                final prefs = await SharedPreferences.getInstance();
                prefs.remove('token');
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
              },
            ),
            new FlatButton(
              child: new Text("NO", textAlign: TextAlign.center,),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
