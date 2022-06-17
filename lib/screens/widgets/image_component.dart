import 'package:flutter/material.dart';

class ImageFromAPI extends StatelessWidget {
  const ImageFromAPI({
    Key? key,
    required this.url,
    required this.imageVariant,
    required this.extention,
  }) : super(key: key);
  final String url;
  final ImageVariant imageVariant;
  final String extention;

  @override
  Widget build(BuildContext context) {
    String imageVariantStr = '';
    switch (imageVariant) {
      case ImageVariant.portraitSmall:
        imageVariantStr = 'portrait_small';
        break;
      case ImageVariant.portraitMedium:
        imageVariantStr = 'portrait_medium';
        break;
      case ImageVariant.portraitXlarge:
        imageVariantStr = 'portrait_xlarge';
        break;
      case ImageVariant.portraitFantastic:
        imageVariantStr = 'portrait_fantastic';
        break;
      case ImageVariant.portraitUncanny:
        imageVariantStr = 'portrait_uncanny';
        break;
      case ImageVariant.portraitIncredible:
        imageVariantStr = 'portrait_incredible';
        break;
      case ImageVariant.detail:
        imageVariantStr = 'detail';
        break;
    }

    return Image.network(
      '$url/$imageVariantStr.${extention.toLowerCase()}',
      errorBuilder: (context, error, stackTrace) {
        return const Text(
          '😢',
          style: TextStyle(fontSize: 32),
        );
      },
      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return const SizedBox(
            height: 32,
            child: CircularProgressIndicator.adaptive(),
          );
        }
      },
    );
  }
}

///
///Image Variants
///https://developer.marvel.com/documentation/images
///

enum ImageVariant {
  portraitSmall,
  portraitMedium,
  portraitXlarge,
  portraitFantastic,
  portraitUncanny,
  portraitIncredible,
  detail
}