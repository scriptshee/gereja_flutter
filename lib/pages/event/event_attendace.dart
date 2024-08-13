// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/pages/home.dart';
import 'package:gereja_flutter/services/event_services.dart';
import 'package:gereja_flutter/themes/components/textinput.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EventAttendace extends StatefulWidget {
  EventAttendace({this.id, super.key});

  int? id;
  @override
  State<EventAttendace> createState() => _EventAttendaceState();
}

class _EventAttendaceState extends State<EventAttendace> {
  EvenServices evenServices = EvenServices();

  final _formAttendaceKey = GlobalKey<FormState>();
  TextEditingController noteController = TextEditingController();

  Future<void> present() async {
    context.loaderOverlay.show();
    if (noteController.text.isNotEmpty) {
      try {
        var resp = await evenServices
            .store(widget.id, {"note": noteController.text, "present": 1});
        debugPrint(resp.toString());
        context.loaderOverlay.hide();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        debugPrint(e.toString());
        context.loaderOverlay.hide();
      }
    }
    context.loaderOverlay.hide();
  }

  Future<void> absence() async {
    context.loaderOverlay.show();
    if (noteController.text.isNotEmpty) {
      try {
        var resp = await evenServices
            .store(widget.id, {"note": noteController.text, "present": 0});
        debugPrint(resp.toString());
        context.loaderOverlay.hide();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        debugPrint(e.toString());
        context.loaderOverlay.hide();
      }
    }
    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Kehadiran"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20.sp, horizontal: 20.sp),
          child: Form(
            key: _formAttendaceKey,
            child: Column(
              children: [
                SimpleTextField(
                  labelText: "Pesan",
                  helperText: "Berikan pesan untuk acara ini.",
                  textEditingController: noteController,
                ),
                SizedBox(height: 20.sp),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => absence(),
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.grey),
                          elevation: MaterialStatePropertyAll(0),
                        ),
                        child: const Text(
                          "Tidak Hadir",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.sp),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => present(),
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(Colors.green),
                          elevation: MaterialStatePropertyAll(0),
                        ),
                        child: const Text(
                          "Hadir",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
