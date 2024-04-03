import 'dart:io';

import 'package:args/args.dart';

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

  final number = int.parse(results['number'] as String);
}
