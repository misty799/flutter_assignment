import 'package:flutter/material.dart';
import 'package:flutter_assignment/Api/ApiAction.dart';
import 'package:flutter_assignment/Api/ApiCallBackListener.dart';
import 'package:flutter_assignment/Api/ApiRequest.dart';
import 'package:flutter_assignment/Api/HttpMethods.dart';
import 'package:flutter_assignment/Api/Url.dart';
import 'package:flutter_assignment/Models/HeadlineModel.dart';
import 'package:flutter_assignment/Utilities/AppHelper.dart';

class HeadlinesProvider extends ChangeNotifier with ApiCallBackListener {
  late BuildContext context;
  List<HeadlineData>? headlines;

  getHeadlines() {
    ApiRequest(context, this, true, HttpMethods.GET, Url.headlines,
        ApiAction.headlines);
  }

  @override
  apiCallBackListener(String action, result) {
    if (action == ApiAction.headlines) {
      HeadlineModel headlineModel = HeadlineModel.fromJson(result);
      headlines = [];
      if (headlineModel.status == "ok") {
        headlines = headlineModel.articles;
        notifyListeners();
      } else {
        notifyListeners();
        AppHelper.showToastMessage("Please try again later");
      }
    }
  }
}
