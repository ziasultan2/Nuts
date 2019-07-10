//import 'package:flutter/material.dart';
//import 'package:flutter_progress_hud/flutter_progress_hud.dart';
//
//class Type extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text('Progress HUD'),
//      ),
//      body: ProgressHUD(
//        child: Builder(
//          builder: (context) => Center(
//            child: Column(
//              children: <Widget>[
//                RaisedButton(
//                  child: Text('Show for a second'),
//                  onPressed: () {
//                    final progress = ProgressHUD.of(context);
//                    progress.show();
//                    Future.delayed(Duration(seconds: 4), () {
//                      progress.dismiss();
//                    });
//                  },
//                ),
//                RaisedButton(
//                  child: Text('Show with text'),
//                  onPressed: () {
//                    final progress = ProgressHUD.of(context);
//                    progress.showWithText('Loading...');
//                    Future.delayed(Duration(seconds: 1), () {
//                      progress.dismiss();
//                    });
//                  },
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
