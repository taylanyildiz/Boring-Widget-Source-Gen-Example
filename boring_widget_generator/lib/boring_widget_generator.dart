import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'src/generator.dart';

Builder boringWidgetGeneratorBuilder(BuilderOptions option) {
  return SharedPartBuilder([BoringWidgetGenerator()], 'boring');
}
