import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SettingReplaced extends StatelessWidget {
  SettingReplaced({
    required this.title,
    this.content,
    super.key,
  });

  final String title;
  String? content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 20.sp),
          child: HtmlWidget("$content"),
        ),
      ),
    );
  }
}
