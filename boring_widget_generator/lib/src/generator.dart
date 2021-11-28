import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:analyzer/dart/element/type.dart';

class BoringWidgetGenerator extends GeneratorForAnnotation<JsonSerializable> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return _generateWidgetSource(element);
  }

  String _generateWidgetSource(Element element) {
    var visitor = ModelVisitor();
    element.visitChildren(visitor);

    var classBuffer = StringBuffer();
    var widgetName = "${visitor.className}Widget";
    classBuffer.writeln("class $widgetName extends StatelessWidget {");
    classBuffer.writeln("$widgetName(");
    for (var parameters in visitor.fields.keys) {
      classBuffer.writeln("this.$parameters,");
    }
    classBuffer.writeln(");");
    for (var name in visitor.fields.keys) {
      classBuffer.writeln("final ${visitor.fields[name]} $name;");
    }
    classBuffer.writeln("}");
    // return '/* Generator works! ${visitor.className} */';
    return "/* ${classBuffer.toString()}*/";
  }
}

class ModelVisitor extends SimpleElementVisitor {
  DartType? className;
  Map<String, DartType> fields = {};
  @override
  visitConstructorElement(ConstructorElement element) {
    assert(className == null);
    className = element.type.returnType;
  }

  @override
  visitFieldElement(FieldElement element) {
    fields[element.name] = element.type;
  }
}
