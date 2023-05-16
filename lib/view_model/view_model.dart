import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:image_pick_web_display_sample/model/image_pick_manager.dart';

class ViewModel extends ChangeNotifier {
  final ImagePickManager imagePickManager;
  ViewModel({required this.imagePickManager});

  bool isLoading = false;

  //スマホはFile（dart.io）使える
  File? imageFileForSP;
  //WebはFileが使えないのでバイトデータ
  Uint8List? imageBytesForWeb;

  void pickImage() async {
    this.isLoading = true;
    notifyListeners();

    if (kIsWeb) {
      imageBytesForWeb = await imagePickManager.pickImageForWeb();
    } else {
      imageFileForSP = await imagePickManager.pickImageForSP();
    }
    this.isLoading = false;
    notifyListeners();
  }

  void clearImage() {
    imageFileForSP = null;
    imageBytesForWeb = null;
    notifyListeners();
  }



}