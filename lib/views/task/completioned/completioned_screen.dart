
import 'package:authbase_mobile/components/widgets/app_header.dart';
import 'package:authbase_mobile/views/app.dart';
import 'package:flutter/material.dart';

class CompletionedScreen extends StatelessWidget {
  const CompletionedScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppHeader(currentPage: PageType.task),
      body: Column(
        children: [
          Text("写真撮ってね！")
        ],
      ),
    );
  }
}