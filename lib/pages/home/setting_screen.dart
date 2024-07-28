// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/pages/setting/setting_replaced.dart';
import 'package:gereja_flutter/services/setting_services.dart';
import 'package:loader_overlay/loader_overlay.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  SettingServices settingServices = SettingServices();

  String? content;

  List menu = [
    {
      "label": "Visi",
      "value": "visi",
    },
    {
      "label": "Misi",
      "value": "misi",
    }
  ];

  Future<void> openDetail(String value) async {
    context.loaderOverlay.show();
    try {
      var resp = await settingServices.get(value);
      if (resp.statusCode == 200) {
        setState(() {
          content = resp.data['data'];
        });
      }
      context.loaderOverlay.hide();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingReplaced(
            title: value,
            content: content,
          ),
        ),
      );
    } catch (e) {
      context.loaderOverlay.hide();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: menu.length,
        itemBuilder: (BuildContext, index) {
          var item = menu[index];
          return GestureDetector(
            onTap: () => openDetail(item['value']),
            child: Container(
              margin: EdgeInsets.only(top: 10.sp),
              padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 10.sp),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(8.sp),
              ),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Column(
                      children: [Text("${item['label']}")],
                    ),
                  ),
                  const Icon(Icons.arrow_forward)
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
