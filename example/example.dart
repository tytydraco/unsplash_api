import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:unsplash_api/unsplash_api.dart';

Future<void> main() async {
  final unsplashImages = await getPhotos('Autumn', 10);

  for (var image in unsplashImages) {
    print(image.description);
    print(image.creationDate);
    print(image.imageUrls.raw);

    final uri = Uri.parse(image.imageUrls.raw);
    final response = await http.get(uri);
    final file = File('${uri.pathSegments.last}.jpeg');
    await file.writeAsBytes(response.bodyBytes);
  }
}
