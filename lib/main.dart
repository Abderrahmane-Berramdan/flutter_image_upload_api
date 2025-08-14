import 'package:flutter/material.dart';
import 'package:upload_image_toapi/screen/upload_image_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const UploadImageScreen(),
    );
  }
}
