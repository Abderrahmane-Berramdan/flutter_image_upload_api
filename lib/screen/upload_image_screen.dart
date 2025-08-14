import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upload_image_toapi/service/upload_api_image.dart';

class UploadImageScreen extends StatefulWidget {
  const UploadImageScreen({super.key});

  @override
  State<UploadImageScreen> createState() => _UploadImageScreenState();
}

class _UploadImageScreenState extends State<UploadImageScreen> {
  String isImageUpload = "";
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            isLoading
                ? CircularProgressIndicator()
                : Column(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isImageUpload == ""
                        ? SizedBox()
                        : SizedBox(
                          height: 350,
                          width: 350,
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(20),
                            child: Image.network(isImageUpload),
                          ),
                        ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery,
                        );

                        if (image != null) {
                          setState(() {
                            isLoading = true;
                          });
                          Uint8List bytes = await image.readAsBytes();
                          UploadApiImage.uploadImage(bytes, image.name)
                              .then((value) {
                                setState(() {
                                  isImageUpload = value["location"].toString();
                                  isLoading = false;
                                });
                                print(
                                  "Uplade Successfully ✔✔ with link $value",
                                );
                              })
                              .onError((error, stackTrace) {
                                setState(() {
                                  isLoading = false;
                                });
                                print(" ❌📛📛${error.toString()}");
                              });
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "Upload Image",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
