import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomCacheImage extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final bool? circularShape;
  final BoxFit ?fit;
  const CustomCacheImage(
      {Key? key,
      required this.imageUrl,
      required this.radius,
      this.circularShape,
      this.fit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
          bottomLeft: Radius.circular(circularShape == false ? 0 : radius),
          bottomRight: Radius.circular(circularShape == false ? 0 : radius)),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: fit == null ? BoxFit.cover : fit,
        height: MediaQuery.of(context).size.width / 0.85,
        placeholder: (context, url) => Container(color: Colors.grey[300]),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey[300],
          child: Icon(Icons.error),
        ),
      ),
    );
  }
}
