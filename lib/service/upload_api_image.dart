import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

/// A service class responsible for uploading images to an API endpoint.
class UploadApiImage {
  /// Uploads an image file to the API.
  ///
  /// [bytes] - The raw image data as a Uint8List.
  /// [fileName] - The name to assign to the uploaded file.
  /// Returns the decoded JSON response from the API if successful.
  /// Throws an exception if the upload fails.
  static Future<dynamic> uploadImage(Uint8List bytes, String fileName) async {
    // Define the API endpoint URL for file uploads.
    Uri url = Uri.parse("https://api.escuelajs.co/api/v1/files/upload");

    // Create a multipart HTTP request with POST method for file upload.
    var request = http.MultipartRequest("POST", url);

    // Construct a multipart file using the provided image bytes and filename.
    // "file" is the field name expected by the API.
    var myFile = http.MultipartFile(
      "file", // Field name for the file in the form data.
      http.ByteStream.fromBytes(bytes), // Convert bytes to a byte stream.
      bytes.length, // Specify the length of the byte stream.
      filename: fileName, // Set the filename for the uploaded file.
    );

    // Attach the multipart file to the request.
    request.files.add(myFile);

    // Send the multipart request to the server and wait for the response.
    final response = await request.send();

    // Check if the server responded with a success status code (201 Created).
    if (response.statusCode == 201) {
      // Read the response stream and convert it to a string.
      var data = await response.stream.bytesToString();

      // Decode the JSON response and return it.
      return jsonDecode(data);
    } else {
      // If the upload failed, throw an exception with the status code.
      throw Exception("Upload failed with status code: ${response.statusCode}");
    }
  }
}