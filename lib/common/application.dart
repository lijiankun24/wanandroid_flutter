import '../data/net_manager.dart';
import '../data/api.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/widgets.dart';

class Application {
  static NetManager netManager;

  static Future globalInit(VoidCallback callback) async {
    netManager = NetManager(Api.BASE_URL);
    netManager.addInterceptor(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
    callback();
    if (Platform.isAndroid) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      );
    }
  }
}
