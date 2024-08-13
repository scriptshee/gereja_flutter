// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/models/event_model.dart';
import 'package:gereja_flutter/pages/event/event_detail.dart';
import 'package:gereja_flutter/services/attendace_services.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AttendacePage extends StatefulWidget {
  const AttendacePage({super.key});

  @override
  State<AttendacePage> createState() => _AttendacePageState();
}

class _AttendacePageState extends State<AttendacePage> {
  AttendaceServices attendaceServices = AttendaceServices();
  List<dynamic> attendaceList = [];

  Future<void> fetchDate() async {
    context.loaderOverlay.show();
    try {
      var resp = await attendaceServices.get();
      print(resp);
      if (resp.statusCode == 200) {
        List<dynamic> dataresp = resp.data['data'] as List;
        // print(dataresp.length);
        // List<AttendaceModel> data =
        //     dataresp.map((e) => AttendaceModel.fromJson(e)).toList();

        setState(() {
          attendaceList = dataresp;
        });
      }
      context.loaderOverlay.hide();
    } catch (e) {
      context.loaderOverlay.hide();
    }
    context.loaderOverlay.hide();
  }

  @override
  void initState() {
    super.initState();
    fetchDate();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: attendaceList.length,
              itemBuilder: (context, index) {
                var item = attendaceList[index];
                if (attendaceList.length > 0) {
                  return GestureDetector(
                    onTap: () {
                      EventModel event = EventModel.fromJson(item['event']);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EventDetail(event: event),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10.sp),
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.sp, vertical: 10.sp),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8.sp),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${item['event']['title']}",
                              softWrap: true,
                            ),
                            SizedBox(height: 5.sp),
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Start date',
                                      style: TextStyle(fontSize: 8),
                                    ),
                                    Text(
                                      "${item['event']['start_datetime']} - ",
                                      softWrap: true,
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Start date',
                                      style: TextStyle(fontSize: 8),
                                    ),
                                    Text(
                                      "${item['event']['end_datetime']}",
                                      softWrap: true,
                                      style: TextStyle(fontSize: 10.sp),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    child: Text("Notifikasi kosong"),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
