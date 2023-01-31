import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/Models/HeadlineModel.dart';
import 'package:flutter_assignment/Utilities/AppHelper.dart';
import 'package:flutter_assignment/Utilities/ImageHelper.dart';
import 'package:intl/intl.dart';

import '../Utilities/AppColor.dart';

class NewsDetailsScreen extends StatefulWidget {
  final HeadlineData headlineData;
  const NewsDetailsScreen({super.key, required this.headlineData});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      ImageHelper.imageView(widget.headlineData.urlToImage ?? "",
          height: AppHelper.getDeviceHeight(context), fit: BoxFit.fitHeight),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(widget.headlineData.title ?? "",
                style: TextStyle(
                    fontFamily: "RobotoSlab-Bold",
                    fontSize: 29,
                    color: AppColor.whiteColor)),
            SizedBox(
              height: 64,
            ),
            Row(
              children: [
                Text(
                  widget.headlineData.source != null
                      ? widget.headlineData.source!["name"] ?? ""
                      : "",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "RobotoSlab-Regular",
                      color: AppColor.whiteColor),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  DateFormat('yyyy-MM-dd').format(
                      DateTime.parse(widget.headlineData.publishedAt ?? "")),
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "RobotoSlab-Regular",
                      color: AppColor.whiteColor),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            AnimatedTextKit(
              totalRepeatCount: 1,
              isRepeatingAnimation: false,
              animatedTexts: [
                TyperAnimatedText(widget.headlineData.content ?? "",
                    textStyle: TextStyle(
                        fontSize: 14,
                        fontFamily: "RobotoSlab-Regular",
                        color: AppColor.lightGreyColor)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      )
    ]));
  }
}
