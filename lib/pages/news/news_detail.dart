import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gereja_flutter/models/news_model.dart';

class NewsDetail extends StatefulWidget {
  NewsDetail({
    this.event,
    super.key,
  });

  News? event;
  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.event?.title}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.network("${widget.event?.thumbnail}"),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.event?.title}",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${widget.event?.publishedDate}",
                    style: TextStyle(
                      fontSize: 12.sp,
                    ),
                  ),
                  SizedBox(height: 20.sp),
                  HtmlWidget("${widget.event!.content}")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
