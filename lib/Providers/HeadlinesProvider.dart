import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/Api/ApiAction.dart';
import 'package:flutter_assignment/Api/ApiCallBackListener.dart';
import 'package:flutter_assignment/Api/ApiRequest.dart';
import 'package:flutter_assignment/Api/HttpMethods.dart';
import 'package:flutter_assignment/Api/Url.dart';
import 'package:flutter_assignment/Models/HeadlineModel.dart';
import 'package:flutter_assignment/Utilities/AppHelper.dart';
import 'package:flutter_assignment/Utilities/AppSession.dart';

class HeadlinesProvider extends ChangeNotifier with ApiCallBackListener {
  late BuildContext context;
  List<HeadlineData>? headlines;

  getHeadlines() {
    AppHelper.checkInternetConnectivity().then((bool isConnected) async {
      if (isConnected) {
        ApiRequest(context, this, false, HttpMethods.GET, Url.headlines,
            ApiAction.headlines);
      } else {
        final data = await AppSession.getHeadlines();
        if (data != null) {
          List<dynamic> value = json.decode(data);

          headlines = value.map((e) => HeadlineData.fromJson(e)).toList();
          notifyListeners();
        } else {
          headlines = [];
          notifyListeners();
        }
      }
    });
  }

  @override
  apiCallBackListener(String action, result) {
    if (action == ApiAction.headlines) {
      HeadlineModel headlineModel = HeadlineModel.fromJson(result);
      headlines = [];
      if (headlineModel.status == "ok") {
        headlines = headlineModel.articles;
        headlines!.map((e) => e.toJson()).toList();
        final data = json.encode(headlines);

        AppSession.saveHeadlines(data);
        notifyListeners();
      } else {
        notifyListeners();
        AppHelper.showToastMessage("Please try again later");
      }
    }
  }
}
