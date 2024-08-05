// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/services/attendace_services.dart';
import 'package:gereja_flutter/models/attendace_model.dart';
import 'package:loader_overlay/loader_overlay.dart';

class AttendacePage extends StatefulWidget {
  const AttendacePage({super.key});

  @override
  State<AttendacePage> createState() => _AttendacePageState();
}

class _AttendacePageState extends State<AttendacePage> {
  AttendaceServices attendaceServices = AttendaceServices();
  List<AttendaceModel> attendaceList = [];

  Future<void> fetchDate() async {
    context.loaderOverlay.show();
    try {
      var resp = await attendaceServices.get();
      if (resp.statusCode == 200) {
        List<dynamic> dataresp = resp.data['data'] as List;
        List<AttendaceModel> data =
            dataresp.map((e) => AttendaceModel.fromJson(e)).toList();
        setState(() {
          attendaceList = data;
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
                AttendaceModel item = attendaceList[index];
                if (attendaceList.length > 0) {
                  return Container(
                    margin: EdgeInsets.only(top: 10.sp),
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.sp, vertical: 10.sp),
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
                            "${item.event}",
                            softWrap: true,
                          ),
                          SizedBox(height: 3.sp),
                          Text(
                            "${item.eventStart}",
                            softWrap: true,
                            style: TextStyle(fontSize: 10.sp),
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
