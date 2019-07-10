import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sohel_nuts/network/network.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'home.dart';


class Login extends StatefulWidget {
  Login({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<ScaffoldState> mScaffoldState = new GlobalKey<ScaffoldState>();

  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  final email = new TextEditingController();
  final password = new TextEditingController();

  final _minimumPadding = 5.0;

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    return
      MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: mScaffoldState,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Text('Login'),
          automaticallyImplyLeading: false,
        ),

        body: Container(
          margin: EdgeInsets.all(_minimumPadding*8),
          child: Form(
            key: _key,
            autovalidate: _validate,
            child: ListView(
              children: <Widget>[
                getImageAsset(),

                Padding(
                    padding: EdgeInsets.only(top: _minimumPadding*4,bottom: _minimumPadding*4),
                    child:
                    TextFormField(
                      validator: validateEmail,
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 25.0),

                      decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter Your Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          prefixIcon: Icon(Icons.email)
                      ),
                    )
                ), // Email

                Padding(
                    padding: EdgeInsets.only(top: _minimumPadding*4,bottom: _minimumPadding*4),
                    child:
                    TextFormField(
                      validator: validatePassword,
                      controller: password,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      style: TextStyle(fontSize: 25.0,),
                      decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Your Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          prefixIcon: Icon(Icons.lock)
                      ),
                    )
                ), // Password

                Padding(
                  padding: EdgeInsets.only(top: _minimumPadding*5, bottom: _minimumPadding*5),
                  child:
                  RaisedButton(shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.green,
                    textColor: Colors.white,
                    padding: EdgeInsets.only(top: _minimumPadding*4, bottom: _minimumPadding*4),
                    child:  Text(
                      'Login to your account',
                      style: new TextStyle(
                        fontSize: 25.0,
                      ),
                    ),
                    onPressed: _onSubmit,

                  ),
                ), // Login To your account

                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 30.0),
                  child:InkWell(
                    child: Text('Forgot Password', style: TextStyle(fontSize: 25.0, decoration: TextDecoration.underline),),
                    onTap: () {print('zia');},
                  ),

                ),
              ],
            ),
          ),
        ),

      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/logo.jpg');
    Image image = Image(image: assetImage, width: 120.0,height: 120.0);

    return Container(child: image, margin: EdgeInsets.all(_minimumPadding*10));
  }

  void _onSubmit() {

    if( _key.currentState.validate()) {
      var url = "${Network.login}";
      print(url);
      http.post(
          url,
          headers: {"Accept": "application/json"},
          body: {'email': email.text, 'password': password.text}).then((
          response) async {
        var token = jsonDecode(response.body)['token'];
        var email = jsonDecode(response.body)['email'];
        var id = jsonDecode(response.body)['userId'];
        if (token != null) {
          // Here details need to store in sharedpref for further use
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', token);
          prefs.setInt('id', id);
          prefs.setString('email', email);

          http.get("${Network.url}",
              headers: {"Accept": "application/json", 'Authorization': token})
              .then((y) {
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new Home()));
          }).catchError((ex) {
            print(ex.toString());
          });
        } else {
          mScaffoldState.currentState.showSnackBar(
            SnackBar(
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
                content: Text('Login Failed')),
          );
        }
      }).catchError((e) {
        mScaffoldState.currentState.showSnackBar(
          SnackBar(
              backgroundColor: Colors.green,
              duration: Duration(seconds: 3),
              content: Text('ERROR')),
        );
      });
    }

  }

  String validateEmail(String value) {
    if(value.length < 3)
    {
      return "Email is Required";
    }else{
      return null;
    }
  }

  String validatePassword(String value) {
    if(value.length < 3)
    {
      return "Password is Required";
    }else{
      return null;
    }
  }
}
