import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_assignment/Models/HeadlineModel.dart';
import 'package:flutter_assignment/Providers/HeadlinesProvider.dart';
import 'package:flutter_assignment/Utilities/ProgressDialog.dart';
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
      appBar: AppBar(title: Text("Headlines")),
      body: Consumer<HeadlinesProvider>(
        builder: (context, value, child) {
          if (value.headlines != null) {
            return ListView.builder(
                itemCount: value.headlines!.length,
                itemBuilder: (context, i) {
                  HeadlineData data = value.headlines![i];
                  return Text(data.title ?? "");
                });
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
