import 'dart:io';

String FixtureReader(String filename) =>
    File('test/fixtures/$filename').readAsStringSync();
