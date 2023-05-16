import 'package:flutter/material.dart';
import 'package:image_pick_web_display_sample/view/home_screen.dart';
import 'package:image_pick_web_display_sample/model/image_pick_manager.dart';
import 'package:image_pick_web_display_sample/view_model/view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<ImagePickManager>(
          create: (_) => ImagePickManager(),
        ),
        ChangeNotifierProvider<ViewModel>(
          create: (context) => ViewModel(
            imagePickManager: context.read<ImagePickManager>(),
          ),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}
