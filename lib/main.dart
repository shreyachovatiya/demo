import 'package:flutter/material.dart';

import 'demo_pagination/demo_pagination.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo123',
      home: PaginatedListView(),
    );
  }
}
