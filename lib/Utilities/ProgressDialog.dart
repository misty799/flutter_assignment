import 'package:flutter/material.dart';

class ProgressDialog {
  static OverlayEntry? currentLoader;
  static bool isShowing = false;

  static void show(BuildContext context) {
    if (!isShowing) {
      currentLoader = new OverlayEntry(
        builder: (context) => GestureDetector(
          child: Center(
            child: Container(
              alignment: Alignment.center,
              color: Colors.transparent,
              child: getCircularProgressIndicator(),
            ),
          ),
          onTap: () {
            // do nothing
          },
        ),
      );
      Overlay.of(context)!.insert(currentLoader!);
      isShowing = true;
    }
  }

  static void hide() {
    if (currentLoader != null) {
      currentLoader?.remove();
      isShowing = false;
      currentLoader = null;
    }
  }

  static getCircularProgressIndicator({double? height, double? width}) {
    if (height == null) {
      height = 40.0;
    }
    if (width == null) {
      width = 40.0;
    }
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        ),
        height: height,
        width: width,
      ),
    );
  }

  static getErrorWidget() {
    return Container(
      alignment: Alignment.center,
      child: SizedBox(
        child: Text("Oops! Something went wrong."),
      ),
    );
  }
}
