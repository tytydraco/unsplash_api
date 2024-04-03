import 'dart:io';

import 'package:args/args.dart';
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
      'number',
      abbr: 'n',
      defaultsTo: '1',
      help: 'The number of photos to download.',
    )
    ..addFlag(
      'watermarked',
      abbr: 'w',
      help: 'Include watermarked (premium or plus) photos.',
    );

  return argParser.parse(args);
}

Future<void> main(List<String> args) async {
  // Get results.
  final results = _parseArgs(args);
  final query = results.rest.join(' ');

  final number = int.parse(results['number'] as String);
  final watermarked = results['watermarked'] as bool;

  await getPhotos(
    query,
    number,
    includeWatermarked: watermarked,
  ).forEach((photo) {
    stdout.writeln('[*] ${photo.slug}');
  });
}
