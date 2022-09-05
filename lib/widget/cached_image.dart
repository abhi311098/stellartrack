import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedImage extends StatelessWidget {
  String? imageUrl;
  double? width;
  double? heigth;
  CachedImage({Key? key, this.imageUrl, this.width, this.heigth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  CachedNetworkImage(
      width: width ?? 100,
      height: heigth ?? 100,
      imageUrl:
      imageUrl!,
      fit: BoxFit.fill,
      filterQuality: FilterQuality.high,
      errorWidget: (context, _, __) => Container(
        width: 100,
        height: 100,
        color: Colors.black12,
      ),
    );
  }
}
