/// Image URLs for the image.
class ImageUrls {
  /// Creates a new [ImageUrls].
  ImageUrls({
    required this.raw,
    required this.full,
    required this.regular,
    required this.small,
    required this.thumb,
    required this.smallS3,
  });

  /// Creates a new [ImageUrls] from JSON.
  ImageUrls.fromJson(Map<String, dynamic> json)
      : raw = json['raw'] as String,
        full = json['full'] as String,
        regular = json['regular'] as String,
        small = json['small'] as String,
        thumb = json['thumb'] as String,
        smallS3 = json['smallS3'] as String;

  /// Returns the object JSON.
  Map<String, dynamic> toJson() => {
        'raw': raw,
        'full': full,
        'regular': regular,
        'small': small,
        'thumb': thumb,
        'smallS3': smallS3,
      };

  /// Raw image URL.
  final String raw;

  /// Full image URL.
  final String full;

  /// Regular image URL.
  final String regular;

  /// Small image URL.
  final String small;

  /// Thumbnail image URL.
  final String thumb;

  /// S3 image URL.
  final String smallS3;
}

/// The unsplash image model.
class UnsplashImage {
  /// Creates a new [UnsplashImage].
  UnsplashImage({
    required this.id,
    required this.slug,
    required this.creationDate,
    required this.width,
    required this.height,
    required this.color,
    required this.description,
    required this.imageUrls,
    required this.webUrl,
    required this.isPremium,
    required this.isPlus,
    required this.userName,
    required this.authorName,
    required this.authorUrl,
  });

  /// Creates a new [UnsplashImage] from serialized JSON.
  UnsplashImage.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        slug = json['slug'] as String,
        creationDate =
            DateTime.fromMillisecondsSinceEpoch(json['creationDate'] as int),
        width = json['width'] as int,
        height = json['height'] as int,
        color = json['color'] as String,
        description = json['description'] as String,
        imageUrls = ImageUrls.fromJson(json['urls'] as Map<String, String>),
        webUrl = json['webUrl'] as String,
        isPremium = json['isPremium'] as bool,
        isPlus = json['isPlus'] as bool,
        userName = json['userName'] as String,
        authorName = json['authorName'] as String,
        authorUrl = json['authorUrl'] as String;

  /// Returns the object JSON.
  Map<String, dynamic> toJson() => {
        'id': id,
        'slug': slug,
        'creationDate': creationDate.millisecondsSinceEpoch,
        'width': width,
        'height': height,
        'color': color,
        'description': description,
        'imageUrls': imageUrls.toJson(),
        'webUrl': webUrl,
        'isPremium': isPremium,
        'isPlus': isPlus,
        'userName': userName,
        'authorName': authorName,
        'authorUr;': authorUrl,
      };

  /// The image ID.
  final String id;

  /// The image slug.
  final String slug;

  /// The creation date of the image.
  final DateTime creationDate;

  /// The image width in pixels.
  final int width;

  /// The image height in pixels.
  final int height;

  /// The predominant image color in hexadecimal.
  final String color;

  /// The image description.
  final String? description;

  /// The image URLs.
  final ImageUrls imageUrls;

  /// The Unsplash image URL.
  final String webUrl;

  /// True if the image requires an Unsplash premium account.
  final bool isPremium;

  /// True if the image requires an Unsplash plus account.
  final bool isPlus;

  /// The original artist's username.
  final String userName;

  /// The original artist's name.
  final String authorName;

  /// The original authors Unsplash URL.
  final String authorUrl;
}
