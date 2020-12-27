import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

showAlertDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('No Internet Connection'),
            content: Text('Check your internet connection and retry'),
            actions: [
              FlatButton(
                  onPressed: () {
                    SystemChannels.platform
                        .invokeMethod<void>('SystemNavigator.pop');
                  },
                  child: new Text("Exit")),
            ],
          ));
}
