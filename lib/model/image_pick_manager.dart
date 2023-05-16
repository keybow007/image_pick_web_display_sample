import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class ImagePickManager {
  /*
  * Webの場合パスは取ってこれず、ファイルのバイトデータは持ってこれるみたいなので、バイトデータからファイルを作る必要あり
  * https://github.com/miguelpruivo/flutter_file_picker/wiki/api#-pickfiles
  * On web the path will always be null as web always use fake paths,
  * you should use the bytes instead to retrieve the picked file data.
  *
  * https://github.com/miguelpruivo/flutter_file_picker/wiki/FAQ#q-how-do-i-access-the-path-on-web
  * Paths aren't inaccessible from browsers since those provide fake paths.
  * If you want to create a File instance to upload it somewhere, like Firebase Storage, you can do so with the bytes directly.
  *
  * => スマホの場合はpathからFileインスタンスを作ってImage.fileで表示できるが、
  *    Image.fileはWebで使えずImage.memoryで対応する必要があり
  * => であれば、全プラットフォーム共通でバイトデータ(bytes)に統一しようとかと思ったが
  *    これがまたトラップ的なことにbytesはスマホの場合はnullになってしまう
  * => スマホとWebで対応を分ける必要あり（スマホはFile/Webはbytes）
  * */

  Future<File?> pickImageForSP() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return null;
    final path = result.files.single.path;
    return (path == null) ? null : File(path);
  }

  Future<Uint8List?> pickImageForWeb() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null) return null;
    return result.files.first.bytes;
  }
}
