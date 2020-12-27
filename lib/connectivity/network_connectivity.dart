import 'dart:async';

import 'package:country_info/widget/alert_dialog.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/cupertino.dart';

class NetworkConnectivityService {
  static checkConnection(BuildContext context,
      StreamSubscription<DataConnectionStatus> subscription) async {
    subscription = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          print('connected');
          break;
        case DataConnectionStatus.disconnected:
          showAlertDialog(context);
          break;
      }
    });
    return await DataConnectionChecker().connectionStatus;
  }
}
