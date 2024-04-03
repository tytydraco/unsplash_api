import 'dart:io';

import 'package:unsplash_api/unsplash_api.dart';

Future<void> main() async {
  final unsplashImages = getPhotos('Autumn', 10);

  await for (final image in unsplashImages) {
    stdout
      ..writeln(image.description)
      ..writeln(image.creationDate)
      ..writeln(image.imageUrls.raw);
  }
}
