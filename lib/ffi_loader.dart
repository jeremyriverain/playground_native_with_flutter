// ignore_for_file: avoid_print

import 'dart:ffi';
import 'dart:io';

import 'package:batterylevel/ffi/cjson_generated_bindings.dart' as cj;
import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart' show rootBundle;

class MyNativeCJson {
  MyNativeCJson({
    required this.pathToJson,
  }) {
    final cJSONNative = Platform.isAndroid
        ? DynamicLibrary.open('libcjson.so')
        : DynamicLibrary.process();
    cjson = cj.CJson(cJSONNative);
  }
  late cj.CJson cjson;
  final String pathToJson;
  Future<dynamic> load() async {
    final jsonString = await rootBundle.loadString('assets/$pathToJson');
    final cjsonParsedJson = cjson.cJSON_Parse(jsonString.toNativeUtf8().cast());
    if (cjsonParsedJson == nullptr) {
      print('Error parsing cjson.');
    }
    final dynamic dartJson = convertCJsonToDartObj(cjsonParsedJson.cast());
    cjson.cJSON_Delete(cjsonParsedJson);
    return dartJson;
  }

  dynamic convertCJsonToDartObj(Pointer<cj.cJSON> parsedcjson) {
    dynamic obj;
    if (cjson.cJSON_IsObject(parsedcjson.cast()) == 1) {
      obj = <String, dynamic>{};
      Pointer<cj.cJSON>? ptr;
      ptr = parsedcjson.ref.child;
      while (ptr != nullptr) {
        final dynamic o = convertCJsonToDartObj(ptr!);
        _addToObj(obj, o, ptr.ref.string.cast());
        ptr = ptr.ref.next;
      }
    } else if (cjson.cJSON_IsArray(parsedcjson.cast()) == 1) {
      obj = <dynamic>[];
      Pointer<cj.cJSON>? ptr;
      ptr = parsedcjson.ref.child;
      while (ptr != nullptr) {
        final dynamic o = convertCJsonToDartObj(ptr!);
        _addToObj(obj, o);
        ptr = ptr.ref.next;
      }
    } else if (cjson.cJSON_IsString(parsedcjson.cast()) == 1) {
      obj = parsedcjson.ref.valuestring.cast<Utf8>().toDartString();
    } else if (cjson.cJSON_IsNumber(parsedcjson.cast()) == 1) {
      obj = parsedcjson.ref.valueint == parsedcjson.ref.valuedouble
          ? parsedcjson.ref.valueint
          : parsedcjson.ref.valuedouble;
    }
    return obj;
  }

  void _addToObj(dynamic obj, dynamic o, [Pointer<Utf8>? name]) {
    if (obj is Map<String, dynamic>) {
      obj[name!.toDartString()] = o;
    } else if (obj is List<dynamic>) {
      obj.add(o);
    }
  }
}
