import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as p;
import 'package:unsplash_api/unsplash_api.dart';

ArgResults _parseArgs(List<String> args) {
  final argParser = ArgParser();
  argParser
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Shows the usage.',
      negatable: false,
      callback: (value) {
        if (value) {
          stdout.writeln(argParser.usage);
          exit(0);
        }
      },
    )
    ..addOption(
      'directory',
      abbr: 'd',
      defaultsTo: '.',
      help: 'The directory path for photo downloads.',
    )
    ..addOption(
      'number',
      abbr: 'n',
      defaultsTo: '1',
      help: 'The number of photos to download.',
    )
    ..addOption(
      'quality',
      abbr: 'q',
      defaultsTo: 'full',
      allowed: [
        'smallS3',
        'thumb',
        'small',
        'regular',
        'full',
        'raw',
      ],
    )
    ..addFlag(
      'watermarked',
      abbr: 'w',
      help: 'Include watermarked (premium or plus) photos.',
    )
    ..addFlag(
      'dry',
      abbr: 'e',
      help: 'Dry run; no downloads.',
    )
    ..addFlag(
      'overwrite',
      abbr: 'r',
      help: 'Whether or not to overwrite existing downloads.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      help: 'Provide logging.',
    );

  return argParser.parse(args);
}

Future<void> main(List<String> args) async {
  // Get results.
  final results = _parseArgs(args);
  final query = results.rest.join(' ');

  final directory = results['directory'] as String;
  final number = int.parse(results['number'] as String);
  final quality = results['quality'] as String;
  final dry = results['dry'] as bool;
  final watermarked = results['watermarked'] as bool;
  final overwrite = results['overwrite'] as bool;
  final verbose = results['verbose'] as bool;

  await getPhotos(
    query,
    number,
    includeWatermarked: watermarked,
  ).forEach((photo) async {
    if (verbose) stdout.writeln('[ ] ${photo.slug}');

    // Download the image to disk.
    if (!dry) {
      final imageUrlsQualityMap = <String, String>{
        'smallS3': photo.imageUrls.smallS3,
        'thumb': photo.imageUrls.thumb,
        'small': photo.imageUrls.small,
        'regular': photo.imageUrls.regular,
        'full': photo.imageUrls.full,
        'raw': photo.imageUrls.raw,
      };

      final photoUrl = imageUrlsQualityMap[quality];
      final uri = Uri.parse(photoUrl!);
      final image = await get(uri);

      final file = File(p.join(directory, '${photo.slug}.jpeg'));
      if (!file.existsSync() || overwrite) {
        await file.writeAsBytes(image.bodyBytes);
        if (verbose) stdout.writeln('[+] ${photo.slug}');
      } else {
        if (verbose) stdout.writeln('[-] ${photo.slug}');
      }
    }
  });
}
