import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'viewmodels/chat_viewmodel.dart';
import 'viewmodels/image_detail_viewmodel.dart';
import 'views/chat_view.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Permission.storage.request();
  await Permission.mediaLibrary.request();
  await Permission.photos.request();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatViewModel()),
        ChangeNotifierProvider(create: (_) => ImageDetailViewModel()),
      ],
      child: MaterialApp(
        home: ChatView(),
      ),
    );
  }
}