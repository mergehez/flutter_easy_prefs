import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:build/build.dart';
import 'package:easy_prefs/easy_prefs.dart';
import 'package:source_gen/source_gen.dart';

class FieldInfo {
  static const _supportedTypes = ["int", "double", "bool", "String", "PrefsStringList", "List<String>"];
  final String name, type, valueStr;
  final bool isEnum;

  bool get isStringList => type == "StringList";

  FieldInfo(this.type, this.name, this.valueStr, this.isEnum)
      : assert(isEnum || type == "bool" || type == "int" || type == "String" || type == "double" || type == "StringList",
            "$type is not supported. Supported data types: ${_supportedTypes.join(", ")}");

  static void _throwUnsupportedError(String name, String type) {
    throw UnsupportedError("The data type of '$name' ($type) is not supported. Supported data types: ${_supportedTypes.join(", ")}");
  }

  factory FieldInfo.fromMapEntry(MapEntry<DartObject?, DartObject?> e) {
    if (e.value == null) throw UnsupportedError("'null' is not supported as value!");

    var type = e.value!.type.toString();
    var name = e.key!.toStringValue()!;
    var value = e.value!;

    if ((type.contains("List") && type.contains("String")) || (type == "List<dynamic>" && value.toListValue()?.isEmpty == true)) {
      type = "StringList";
      final list = (value.getField("values") ?? value).toListValue();
      final valueStr = "[${list?.map((e) => "'${e.toStringValue()}'").join(",") ?? ""}]";
      return FieldInfo(type, name, valueStr, false);
    }

    if (value.type?.element?.kind.displayName == "enum") {
      return FieldInfo(type, name, "$type.${value.getField("_name")!.toStringValue()!}", true);
    }

    if (!_supportedTypes.contains(type)) {
      _throwUnsupportedError(name, type);
    }
    return FieldInfo(type, name, value.toString().split("(").last.split(")").first, false);
  }
}

class PrefsGenerator extends GeneratorForAnnotation<PrefsAnnotation> {
  @override
  Future<String> generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) async {
    final className = (element as ClassElement).name;
    final newClassName = "_\$$className";

    final fields = annotation.read("map").mapValue.entries.map(FieldInfo.fromMapEntry).toList();

    final strBuffer = StringBuffer();

    generatePrefKeysClass(strBuffer, className, fields);

    final notifierEnabled = annotation.read("changeNotifier").boolValue;
    final onlyModifier = annotation.read("onlyModifier").boolValue;
    final toggleMethodForBoolValues = annotation.read("toggleMethodForBoolValues").boolValue;

    strBuffer.writeln('''
      class $newClassName with IEasyPrefs ${notifierEnabled ? ", ChangeNotifier" : ""}{
        final _helper = SharedPreferencesHelper();
        final _keys = const _PrefKeysFor$className();
        
        /// if [silent] is true, value changes won't be notified.
        $newClassName({bool silent = false}) {
          if(silent) return;
          _helper.onNotify = onValueChanged;
        }
        
        @override
        void onValueChanged(String key) {
          ${notifierEnabled ? "notifyListeners();" : ""}
        }
    ''');

    for (var e in fields) {
      generateGettersAndSetters(strBuffer, e, onlyModifier, toggleMethodForBoolValues);
    }

    strBuffer.write('''
      @override
      void initializeAll(){
        final tmp = _helper.onNotify;
        _helper.onNotify = null;

        ${fields.map((e) => "${e.name} = ${e.name};").join("\n")}

        _helper.onNotify = tmp;
        _helper.onNotify?.call("");
      }
      
      @override
      bool isTouched(){
        return ${fields.map((e) => "_helper.hasKey(_keys.${e.name})").join("\n  || ")};
      }
    ''');

    generateToStringMethod(strBuffer, fields);

    strBuffer.writeln('}');

    if (annotation.read("providerExtensionMethods").boolValue) {
      generateProviderExtMethods(strBuffer, className);
    }

    return strBuffer.toString();
  }

  void generatePrefKeysClass(StringBuffer strBuffer, String className, List<FieldInfo> fields) {
    strBuffer.writeln('class _PrefKeysFor$className {');
    strBuffer.writeln(' const _PrefKeysFor$className();');
    for (final field in fields) {
      strBuffer.writeln("final String ${field.name} = '${field.name}';");
    }
    strBuffer.writeln('}');
    strBuffer.writeln();
  }

  void generateProviderExtMethods(StringBuffer strBuffer, String className) {
    strBuffer.writeln('''
        extension ${className}ProviderExtensionMethodsOnBuildContext on BuildContext {
          $className read$className() => read<$className>();
          $className watch$className() => watch<$className>();
          R select$className<R>(R Function($className s) selector) => select(selector);
        }
      ''');
    strBuffer.writeln();
  }

  void generateToStringMethod(StringBuffer strBuffer, List<FieldInfo> fields) {
    strBuffer.writeln("@override");
    strBuffer.writeln("String toString(){");
    strBuffer.writeln("  return '''");
    strBuffer.writeln("{");

    for (int i = 0; i < fields.length; i++) {
      var name = fields[i].name;
      var type = fields[i].type;
      var valStr = type == "String" ? '"\$$name"' : '\$$name';
      if (fields[i].isStringList) {
        valStr = '[\n      \${$name.map((e) => \'"\$e"\').join(",\\n      ")}\n    ]';
      }
      if (i != fields.length - 1) valStr += ",";
      strBuffer.writeln("  \"$name\" : $valStr");
    }

    strBuffer.writeln("}");
    strBuffer.writeln("''';");
    strBuffer.writeln("}");
  }

  void generateGettersAndSetters(StringBuffer strBuffer, FieldInfo field, bool onlyModifier, bool toggleMethodForBoolValues) {
    final name = field.name;
    final valueStr = field.valueStr;
    final typeFirstUpperCase = field.type[0].toUpperCase() + field.type.substring(1);
    final type = field.isStringList ? "NotifiableStringList" : field.type;

    if (onlyModifier) {
      strBuffer.writeln('$type? _\$$name;');
    } else if (field.isStringList) {
      strBuffer.writeln("/// **IMPORTANT**: if possible set this to a variable and modify it through the variable!");
    }

    final prefHelper = onlyModifier ? "_\$$name ?? " : "";
    final suffHelper = onlyModifier ? ", (_) => _\$$name = val" : "";

    if (field.isEnum) {
      strBuffer.writeln('$type get $name => $prefHelper _helper.getEnum(_keys.$name, $type.values, $valueStr);');
      strBuffer.writeln('set $name($type val) => _helper.setInt(_keys.$name, val.index $suffHelper);');
    } else {
      strBuffer.writeln('$type get $name => $prefHelper _helper.get$typeFirstUpperCase(_keys.$name, $valueStr);');
      strBuffer.writeln('set $name($type val) => _helper.set$typeFirstUpperCase(_keys.$name, val $suffHelper);');
      if (type == "bool" && toggleMethodForBoolValues) {
        final nameFirstUpperCase = name[0].toUpperCase() + name.substring(1);
        final suffHelper2 = suffHelper.replaceFirst("(_)", "(val)");
        strBuffer.writeln('$type toggle$nameFirstUpperCase() => _helper.toggleBool(_keys.$name, $valueStr $suffHelper2);');
      }
    }

    strBuffer.writeln();
  }
}
