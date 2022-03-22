import 'package:build/build.dart';
import 'package:easy_prefs_gen/prefs_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder prefsGeneratorBuilder(BuilderOptions options) => SharedPartBuilder([PrefsGenerator()], 'prefs');
