import 'dart:io';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart';


class ImageDetailView extends StatelessWidget {
  final String imageUrl;

  const ImageDetailView({super.key, required this.imageUrl});

  Future<void> _saveImage(BuildContext context) async {
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
          final directory = await getDownloadsDirectory();
          final picturesDirectory = Directory('${directory!.path}/Pictures');
          if (!await picturesDirectory.exists()) {
            await picturesDirectory.create(recursive: true);
          }
          final timestamp = DateFormat('dd_MM_yy_HH_mm_ss').format(DateTime.now());
          final filePath = path.join(picturesDirectory.path, 'image_$timestamp.png');
          final file = File(filePath);
          await file.writeAsBytes(response.bodyBytes);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => _saveImage(context),
          ),
        ],
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}