import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sohel_nuts/network/network.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cassia extends StatefulWidget {
  @override
  _CassiaState createState() => _CassiaState();
}

class _CassiaState extends State<Cassia> {

  final GlobalKey<ScaffoldState> mScaffoldState = new GlobalKey<ScaffoldState>();

  GlobalKey<FormState> _key = new GlobalKey();

  final price = TextEditingController();
  final quantity = TextEditingController();
  final sales = TextEditingController();

  var _margin = "";
  var _value = "";
  var _cost = "";

  var _token;
  var _id;

  bool _validate = false;

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.green,
        // Your app THEME-COLOR
        textTheme: new TextTheme(
          body1: new TextStyle(color: Colors.green, fontSize: 20.0),
        ),
      ),

      home: Scaffold(
        key: mScaffoldState,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text('CASSIA'),
            leading: IconButton(icon:Icon(Icons.arrow_back),
              onPressed:() => Navigator.pop(context, false),
            ),
        ),
        body: Container(
          padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
//          decoration: new BoxDecoration(
//            image: new DecorationImage(
//              image: new AssetImage("images/bg.jpg"), fit: BoxFit.cover,),),

          child: ListView(
            children: <Widget>[
              Form(
                key: _key,
                autovalidate: _validate,
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text(
                            'PRICE', style: TextStyle(fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                            textAlign: TextAlign.center,),
                        ),
                        SizedBox(width: 10.0,),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: validatePrice,
                            controller: price,
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.green),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 10.0,),
                        Expanded(
                          flex: 2,
                          child: Text('MT in USD', style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,),
                          textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text('QUANTITY', style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                            textAlign: TextAlign.center,),
                        ),
                        SizedBox(width: 10.0,),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: validateQuantity,
                            controller: quantity,
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.green),
                                textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(width: 10.0,),
                        Expanded(
                          flex: 2,
                          child: Text('MT', style: TextStyle(fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                          textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Text('SALES', style: TextStyle(fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                            textAlign: TextAlign.center,),
                        ),
                        SizedBox(width: 10.0,),
                        Expanded(
                          flex: 3,
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: validateSales,
                            controller: sales,
                            style: TextStyle(
                                fontSize: 15.0, color: Colors.green),
                          textAlign: TextAlign.center,),
                        ),
                        SizedBox(width: 10.0,),
                        Expanded(
                          flex: 2,
                          child: Text('Tk/Kg', style: TextStyle(fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                          textAlign: TextAlign.center,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              Divider(
                height: 70.0,
              ),

              Column(
                children: <Widget>[

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text('MARGIN', style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                          textAlign: TextAlign.right,),
                      ),
                      SizedBox(width: 10.0,),
                      Expanded(
                        flex: 2,
                        child: Text('$_margin',
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.green),
                        textAlign: TextAlign.center,),
                      ),
                      SizedBox(width: 10.0,),
                      Expanded(
                        child: Text('TK', style: TextStyle(fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,),),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text('VALUE', style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                          textAlign: TextAlign.right,),
                      ),
                      SizedBox(width: 10.0,),
                      Expanded(
                        flex: 2,
                        child: Text('$_value',
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.green),
                          textAlign: TextAlign.center,),
                      ),
                      SizedBox(width: 10.0,),
                      Expanded(
                        child: Text('TK', style: TextStyle(fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Text('COST', style: TextStyle(fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                          textAlign: TextAlign.right,),
                      ),
                      SizedBox(width: 10.0,),
                      Expanded(
                        flex: 2,
                        child: Text('$_cost',
                          style: TextStyle(
                              fontSize: 20.0, color: Colors.green),
                          textAlign: TextAlign.center,),
                      ),
                      SizedBox(width: 10.0,),
                      Expanded(
                        child: Text('Tk', style: TextStyle(fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),),
                      ),
                    ],
                  ),
                ],
              ),


              Divider(
                height: 100.0,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child:FlatButton(
                      padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                      onPressed: _clear,
                      child: new Text('CLEAR', style: TextStyle(color: Colors.white, fontSize: 25.0),), color: Colors.green,),
                  ),
                  Expanded(
                    child:FlatButton(
                      padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                      onPressed: _result ,child: new Text('SHOW', style: TextStyle(color: Colors.white, fontSize: 25.0),), color: Colors.green,),
                  ),
                  Expanded(
                    child:FlatButton(
                      padding: EdgeInsets.only(bottom: 20.0, top: 20.0),
                      onPressed: _save ,child: new Text('SAVE', style: TextStyle(color: Colors.white, fontSize: 25.0),), color: Colors.green,),
                  ),
                ],
              ),

              Divider(
                height: 50.0,
              ),

            ],
          )

        ),
      ),
    );

  }


  String validatePrice(String value) {
    if(value.length == 0)
    {
      return "Oruce is Required";
    }else{
      return null;
    }
  }

  String validateQuantity(String value) {
    if(value.length == 0)
    {
      return "Quantity is Required";
    }else{
      return null;
    }
  }

  String validateSales(String value) {
    if(value.length == 0)
    {
      return "Sales is Required";
    }else{
      return null;
    }
  }


  void _result() {
    if( _key.currentState.validate())
      {
        // no error in validation
        var url = "${Network.cassia_result}";
        http.post(
            url,
            headers: {"Accept": "application/json", "Authorization": _token},
            body: {
              'price': price.text,
              'quantity': quantity.text,
              'sales': sales.text,
            }).then((response) async {
          var margin = jsonDecode(response.body)['margin'];
          var value = jsonDecode(response.body)['value'];
          var cost = jsonDecode(response.body)['cost'];

          setState(() {
            _margin = margin.toString();
            _value = value.toString();
            _cost = cost.toString();
          });
        }).catchError((e) {
          print(e.toString());
        });
      }
      else{
        setState(){
          _validate = true;
        }
    }

  } // result

  _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = (prefs.getString('token'));
    });
  }

  void _save() {
    var url = Network.save_cassia;
    http.post(
      url,
        headers: {"Accept": "application/json", "Authorization": _token},
        body: {
          "user_id" : _id.toString(),
          "price" : price.toString(),
          "quantity" : quantity.toString(),
          "sales" : sales.toString()
        }
    ).then((response){
      mScaffoldState.currentState.showSnackBar(
        SnackBar(
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
            content: Text('Saved Successfully')),
      );
    });

  }


  void _clear() {
    setState(() {
      price.text = "";
      quantity.text = "";
      sales.text = "";
      _margin = "";
      _value = "";
      _cost = "";
    });
  }
}