import 'package:unsplash_api/unsplash_api.dart';

Future<void> main() async {
  final unsplashImages = await getPhotos('Autumn', 10);

  for (var image in unsplashImages) {
    print(image.description);
    print(image.creationDate);
    print(image.imageUrls.raw);
  }
}
