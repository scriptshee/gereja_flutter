import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/components/card_event.dart';
import 'package:gereja_flutter/models/event_model.dart';
import 'package:gereja_flutter/pages/event/event_detail.dart';
import 'package:gereja_flutter/services/event_services.dart';
import 'package:loader_overlay/loader_overlay.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  final apiEvent = EvenServices();
  List<EventModel> event = [];

  Future<void> fetchEvent() async {
    context.loaderOverlay.show();
    final resp = await apiEvent.get();
    if (resp.statusCode == 200) {
      List<dynamic> dataresp = resp.data['data'] as List;
      List<EventModel> data =
          dataresp.map((e) => EventModel.fromJson(e)).toList();
      setState(() {
        event = data;
      });
      context.loaderOverlay.hide();
    }
    context.loaderOverlay.hide();
  }

  @override
  void initState() {
    fetchEvent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event"),
        actions: [
          IconButton(onPressed: fetchEvent, icon: const Icon(Icons.refresh))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => fetchEvent(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: event.length,
              itemBuilder: (context, index) {
                EventModel item = event[index];
                return CardEvent(
                  item: item,
                  onTapCard: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventDetail(event: item),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
