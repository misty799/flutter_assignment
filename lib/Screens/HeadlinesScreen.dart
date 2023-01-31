import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/Models/HeadlineModel.dart';
import 'package:flutter_assignment/Providers/HeadlinesProvider.dart';
import 'package:flutter_assignment/Screens/NewsDetailsScreen.dart';
import 'package:flutter_assignment/Utilities/AppColor.dart';
import 'package:flutter_assignment/Utilities/ImageHelper.dart';
import 'package:flutter_assignment/Utilities/ProgressDialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HeadlinesScreen extends StatefulWidget {
  const HeadlinesScreen({super.key});

  @override
  State<HeadlinesScreen> createState() => _HeadlinesScreenState();
}

class _HeadlinesScreenState extends State<HeadlinesScreen> {
  late HeadlinesProvider _headlinesProvider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          "Headlines",
          style: TextStyle(fontFamily: "RobotoSlab-Bold", fontSize: 29),
        ),
        centerTitle: true,
        backgroundColor: AppColor.appBarColor,
      ),
      body: Consumer<HeadlinesProvider>(
        builder: (context, value, child) {
          if (value.headlines != null) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListView.builder(
                  itemCount: value.headlines!.length,
                  itemBuilder: (context, i) {
                    HeadlineData data = value.headlines![i];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                NewsDetailsScreen(headlineData: data)));
                      },
                      child: Container(
                        height: 250,
                        margin: EdgeInsets.only(bottom: 24),
                        child: Card(
                            child: Stack(children: [
                          ImageHelper.imageView(data.urlToImage ?? "",
                              height: 250, fit: BoxFit.fill),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  AnimatedTextKit(
                                    totalRepeatCount: 1,
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewsDetailsScreen(
                                                      headlineData: data)));
                                    },
                                    isRepeatingAnimation: false,
                                    animatedTexts: [
                                      TyperAnimatedText(data.title ?? "",
                                          textStyle: TextStyle(
                                              fontFamily: "RobotoSlab-Regular",
                                              fontSize: 20,
                                              color: AppColor.whiteColor))
                                    ],
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        data.source != null
                                            ? data.source!["name"] ?? ""
                                            : "",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontFamily: "RobotoSlab-Bold",
                                            color: AppColor.lightGreyColor),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(DateFormat('yyyy-MM-dd').format(
                                          DateTime.parse(
                                              data.publishedAt ?? "")))
                                    ],
                                  ),
                                ]),
                          ),
                        ])),
                      ),
                    );
                  }),
            );
          } else {
            return ProgressDialog.getCircularProgressIndicator();
          }
        },
      ),
    );
  }

  @override
  void initState() {
    _headlinesProvider = Provider.of<HeadlinesProvider>(context, listen: false);
    _headlinesProvider.context = context;
    _headlinesProvider.getHeadlines();
    super.initState();
  }
}
