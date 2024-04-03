import 'dart:convert';

import 'package:http/http.dart';
import 'package:unsplash_api/src/unsplash_image.dart';

/// Convert an Unsplash JSON HTML response to an [UnsplashImage].
UnsplashImage convertJsonToImage(Map<String, dynamic> json) {
  final urls = json['urls'] as Map<String, dynamic>;
  final links = json['links'] as Map<String, dynamic>;
  final user = json['user'] as Map<String, dynamic>;
  final userLinks = user['links'] as Map<String, dynamic>;

  return UnsplashImage(
    id: json['id'] as String,
    slug: json['slug'] as String,
    creationDate: DateTime.parse(json['created_at'] as String),
    width: json['width'] as int,
    height: json['height'] as int,
    color: json['color'] as String,
    description: json['description'] as String?,
    imageUrls: ImageUrls(
      raw: urls['raw'] as String,
      full: urls['full'] as String,
      regular: urls['regular'] as String,
      small: urls['small'] as String,
      thumb: urls['thumb'] as String,
      smallS3: urls['small_s3'] as String,
    ),
    webUrl: links['html'] as String,
    isPremium: json['premium'] as bool,
    isPlus: json['plus'] as bool,
    userName: user['username'] as String,
    authorName: user['name'] as String,
    authorUrl: userLinks['html'] as String,
  );
}

/// Returns a list of [UnsplashImage]s.
Stream<UnsplashImage> getPhotos(
  String query,
  int count, {
  bool includeWatermarked = false,
}) async* {
  var completed = 0;
  var page = 0;

  while (completed < count) {
    final uri = Uri.http('unsplash.com', '/napi/search/photos', {
      'per_page': '1',
      'query': query,
      'page': '${page++}',
    });

    final req = await get(uri);
    final json = jsonDecode(req.body) as Map<String, dynamic>;
    final results =
        (json['results'] as List<dynamic>).cast<Map<String, dynamic>>();
    final firstImage = results.first;
    final unsplashImage = convertJsonToImage(firstImage);

    // Ensure that we still provide the correct number of photos if they are
    // watermarked.
    if (!includeWatermarked) {
      if (unsplashImage.isPlus || unsplashImage.isPremium) {
        continue;
      }
    }

    completed++;
    yield unsplashImage;
  }
}
