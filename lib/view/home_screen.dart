import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //今のFlutterではelevationを0.0にするだけでAppBarを完全に透明にできるみたい
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () => _clearImage(context), icon: Icon(Icons.clear)),
        ],
      ),
      body: Center(
        child: Consumer<ViewModel>(
          builder: (context, vm, child) {
            final isLoading = vm.isLoading;
            final imageBytesForWeb = vm.imageBytesForWeb;
            final imageFileForSP = vm.imageFileForSP;
            return (isLoading)
                ? CircularProgressIndicator()
                : _buildLoadedImage(context, imageFileForSP, imageBytesForWeb);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.photo),
        onPressed: () => _pickImage(context),
      ),
    );
  }

  _pickImage(BuildContext context) {
    final vm = context.read<ViewModel>();
    vm.pickImage();
  }

  _clearImage(BuildContext context) {
    final vm = context.read<ViewModel>();
    vm.clearImage();
  }

  Widget _buildLoadedImage(
      BuildContext context, File? imageFileForSP, Uint8List? imageBytesForWeb) {
    if (kIsWeb) {
      return (imageBytesForWeb == null)
          ? Icon(Icons.no_photography)
          : Image.memory(
              imageBytesForWeb,
              fit: BoxFit.contain,
            );
    } else {
      return (imageFileForSP == null)
          ? Icon(Icons.no_photography)
          : Image.file(imageFileForSP);
    }
  }
}
