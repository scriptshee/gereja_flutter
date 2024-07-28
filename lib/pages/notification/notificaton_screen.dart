// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/models/notification_model.dart';
import 'package:gereja_flutter/services/notification_services.dart';
import 'package:loader_overlay/loader_overlay.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationServices notificationServices = NotificationServices();
  List<NotificationModel> notificationList = [];

  Future<void> fetchData() async {
    context.loaderOverlay.show();
    try {
      var resp = await notificationServices.get();
      if (resp.statusCode == 200) {
        List<dynamic> dataresp = resp.data['data'] as List;
        List<NotificationModel> data =
            dataresp.map((e) => NotificationModel.fromJson(e)).toList();
        setState(() {
          notificationList = data;
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
    fetchData();
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
              itemCount: notificationList.length,
              itemBuilder: (context, index) {
                NotificationModel item = notificationList[index];
                if (notificationList.length > 0) {
                  return Container(
                    margin: EdgeInsets.only(top: 10.sp),
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.sp, vertical: 10.sp),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    width: double.infinity,
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${item.title}",
                                softWrap: true,
                              ),
                              Text(
                                "${item.created}",
                                softWrap: true,
                              ),
                            ],
                          ),
                          Text(
                            "${item.context}",
                            style: TextStyle(color: Colors.black45),
                            softWrap: true,
                          ),
                        ],
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
