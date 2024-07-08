import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:gereja_flutter/models/event_model.dart';

class EventDetail extends StatefulWidget {
  EventDetail({
    this.event,
    super.key,
  });

  EventModel? event;
  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
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
                    "${widget.event?.startDatetime}",
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text(
          "Hadir Event",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
