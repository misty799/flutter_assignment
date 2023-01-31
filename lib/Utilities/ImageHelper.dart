import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/Utilities/ProgressDialog.dart';

class ImageHelper {
  static Widget imageView(String url,
      {required double height, required BoxFit fit}) {
    return Builder(builder: (ctx) {
      return ExtendedImage.network(
        url,
        height: height,
        fit: fit,
        cache: true,
        enableMemoryCache: true,
        retries: 3,
        timeRetry: Duration(seconds: 2),
        cacheHeight: 400,
        clearMemoryCacheWhenDispose: true,
        loadStateChanged: (ExtendedImageState extendedImageState) {
          switch (extendedImageState.extendedImageLoadState) {
            case LoadState.loading:
              return Container(
                color: Colors.transparent,
                child: ProgressDialog.getCircularProgressIndicator(),
              );

            case LoadState.completed:
              return extendedImageState.completedWidget;
            case LoadState.failed:
              return const Center(child: Icon(Icons.error));
            default:
              {
                return const Center(child: Icon(Icons.error));
              }
          }
        },
        mode: ExtendedImageMode.none,
        clearMemoryCacheIfFailed: true,
        enableLoadState: true,
        handleLoadingProgress: true,
      );
    });
  }
}
