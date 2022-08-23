import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:user_bank_info_app_flutter/screen/user_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Bank Info App',
      theme: ThemeData(primaryColor: Colors.blueAccent),
      home: const UserListScreen(),
    );
  }
}
