import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';
import 'package:photo_manager/photo_manager.dart';

class ImageDetailViewModel extends ChangeNotifier {
  Future<void> saveImage(String imageUrl, BuildContext context) async {
    // Request permissions
    await Permission.storage.request();
    await Permission.photos.request();
    await Permission.mediaLibrary.request();
    await Permission.manageExternalStorage.request();
    
    // Check permissions
    if (await Permission.storage.isGranted || await Permission.photos.isGranted || await Permission.mediaLibrary.isGranted || await Permission.manageExternalStorage.isGranted) {
      try {
        final response = await http.get(Uri.parse(imageUrl));
        if (response.statusCode == 200) {

          final timestamp = DateFormat('dd_MM_yy_HH_mm_ss').format(DateTime.now());
          final filePath = await _getFilePath(timestamp);

          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);
          await PhotoManager.editor.saveImage(file.readAsBytesSync(), title: "AI Image");

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Image saved to $filePath')),
          );
        } else {
          throw Exception('Failed to download image');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving image: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permission denied to save image')),
      );
    }
  }

  Future<String> _getFilePath(String timestamp) async {
    if (Platform.isAndroid) {
      final directory = await getExternalStorageDirectory();
      final picturesDirectory = Directory('/storage/emulated/0/Pictures');
      if (!await picturesDirectory.exists()) {
        await picturesDirectory.create(recursive: true);
      }
      return path.join(picturesDirectory.path, 'image_$timestamp.png');
    } else {
      final directory = await getTemporaryDirectory();
      return path.join(directory.path, 'image_$timestamp.png');
    }
  }
}