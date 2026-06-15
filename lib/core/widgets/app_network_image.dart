import 'package:flutter/material.dart';

import '../assets/assets.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.fallbackAsset = Assets.assetsImagesEventImage,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final String fallbackAsset;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Image.asset(fallbackAsset, width: width, height: height, fit: fit);
    }

    return Image.network(
      imageUrl,
      width: width,
      height: height,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return SizedBox(
          width: width,
          height: height,
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        );
      },
      errorBuilder: (_, __, ___) {
        return Image.asset(
          fallbackAsset,
          width: width,
          height: height,
          fit: fit,
        );
      },
    );
  }
}
