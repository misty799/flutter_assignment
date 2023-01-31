import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_assignment/Api/ApiCallBackListener.dart';
import 'package:flutter_assignment/Api/HttpMethods.dart';
import 'package:flutter_assignment/Utilities/AppHelper.dart';
import 'package:flutter_assignment/Utilities/ProgressDialog.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../main.dart';

class ApiRequest {
  JsonDecoder jsonDecoder = new JsonDecoder();
  late String url, action = "", httpType = "";
  Map<String, String>? headers;
  Map<String, String>? body;
  late Map<String, dynamic> jsonResult;
  late BuildContext mContext;

  Duration connectionTimeout = Duration(minutes: 10);
  late ApiCallBackListener apiCallBackListener;
  bool showLoader = false;

  ApiRequest(
    BuildContext mContext,
    ApiCallBackListener apiCallBackListener,
    bool showLoader,
    String httpType,
    String url,
    String apiAction, {
    Map<String, String>? body,
  }) {
    this.apiCallBackListener = apiCallBackListener;
    this.url = url;

    this.body = body;
    this.mContext = mContext;
    this.action = apiAction;
    this.httpType = httpType;
    this.showLoader = showLoader;

    AppHelper.checkInternetConnectivity().then((bool isConnected) async {
      if (isConnected) {
        try {
          if (showLoader) {
            ProgressDialog.show(mContext);
          }

          getAPIRequest(url, body: body);
        } catch (onError) {
          print(onError.toString());
        }
      } else {
        AppHelper.showToastMessage("No Internet Connection.");
      }
    });
  }

  getAPIRequest(String url, {body}) async {
    headers = getApiHeader();
    print(
        "\n****************************API REQUEST************************************\n");
    print("\nApiRequest_url===" + url.toString());
    print("\nApiRequest_headers===" + headers.toString());
    print("\nApiRequest_body===" + body.toString());
    print(
        "\n****************************API REQUEST************************************\n");
    Uri uri = Uri.parse(url);
    if (this.httpType == HttpMethods.GET) {
      return http
          .get(
            uri,
            headers: headers,
          )
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    } else if (this.httpType == HttpMethods.POST) {
      return http
          .post(uri, headers: headers, body: body)
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    } else if (this.httpType == HttpMethods.PUT) {
      return http
          .put(uri, headers: headers, body: body)
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    } else if (this.httpType == HttpMethods.DELETE) {
      return http
          .delete(uri, headers: headers)
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    } else if (this.httpType == HttpMethods.PATCH) {
      return http
          .patch(uri, headers: headers, body: body)
          .then(httpResponse)
          .catchError(httpCatch)
          .timeout(connectionTimeout, onTimeout: () {
        apiTimeOut();
      });
    }
  }

  httpCatch(onError) {
    if (showLoader) {
      ProgressDialog.hide();
    }
    print("httpCatch===" + onError.toString());
    AppHelper.showToastMessage('Oops something went wrong!');
  }

  FutureOr httpResponse(Response response) {
    try {
      print(response.body);

      var res = response.body;
      var statusCode = response.statusCode;
      jsonResult = jsonDecoder.convert(res);

      // print(
      //     "\n****************************API RESPONSE************************************\n");

      // print("\n\nApiRequest_HTTP_RESPONSE===" + jsonResult.toString());
      // print("\n\nApiRequest_HTTP_BODY_RESPONSE===" + res);
      // print("\n\nApiRequest_HTTP_RESPONSE_CODE===" + statusCode.toString());

      // print(
      //     "\n****************************API RESPONSE************************************\n");
      if (showLoader) {
        ProgressDialog.hide();
      }
      if (statusCode == 401) {
      } else if (jsonResult != null) {
        print("success===" + jsonResult.toString());
        return apiCallBackListener.apiCallBackListener(action, jsonResult);
      } else {
        if (jsonResult != null && jsonResult['message'] != null) {
          AppHelper.showToastMessage(jsonResult['message'].toString());
        }
      }
    } catch (onError) {
      httpCatch(onError);
    }
  }

  apiTimeOut() {
    if (showLoader) {
      ProgressDialog.hide();
    }
    print('Please try again .');
    AppHelper.showToastMessage("Connection timeout Please try again...");
  }

  Map<String, String> getApiHeader() {
    return {
      HttpHeaders.acceptHeader: 'application/json',
      // HttpHeaders.contentTypeHeader: content,
      // HttpHeaders.authorizationHeader: "Bearer ",
    };
  }
}
