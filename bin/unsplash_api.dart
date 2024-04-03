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
    );

  return argParser.parse(args);
}

Future<void> main(List<String> args) async {
  // Get results.
  final results = _parseArgs(args);
  final query = results.rest.join(' ');

  final number = int.parse(results['number'] as String);

  await getPhotos(query, number).forEach((photo) {
    stdout.writeln('[*] ${photo.slug}');
  });
}
