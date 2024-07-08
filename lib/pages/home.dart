// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/components/SimpleCarousel.dart';
import 'package:gereja_flutter/components/card_event.dart';
import 'package:gereja_flutter/components/card_news.dart';
import 'package:gereja_flutter/const/dummy_data.dart';
import 'package:gereja_flutter/models/event_model.dart';
import 'package:gereja_flutter/pages/event/event_detail.dart';
import 'package:gereja_flutter/pages/event/event_page.dart';
import 'package:gereja_flutter/pages/main.dart';
import 'package:gereja_flutter/pages/news/news_page.dart';
import 'package:gereja_flutter/services/auth_services.dart';
import 'package:gereja_flutter/services/event_services.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> listImg = DummyData.imgList;
  final api = AuthServices();
  final apiEvent = EvenServices();

  List<EventModel> event = [];

  Future<void> logout() async {
    final resp = await api.logout(context);
    if (resp.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MainPage(),
        ),
      );
    }
  }

  Future<void> fetchEvent() async {
    final resp = await apiEvent.get();
    if (resp.statusCode == 200) {
      List<dynamic> dataresp = resp.data['data'] as List;
      List<EventModel> data =
          dataresp.map((e) => EventModel.fromJson(e)).toList();
      setState(() {
        event = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchEvent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image(
          image: const AssetImage('assets/logo_gereja.png'),
          width: 40.sp,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () => logout(), icon: Icon(Icons.login))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => fetchEvent(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SimpleCarousel(imgList: listImg),
              TextSaparator(
                title: "Event",
                showMore: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EventPage(),
                    ),
                  );
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: event.length,
                itemBuilder: (contex, index) {
                  EventModel item = event[index];
                  return ListTile(
                    title: CardEvent(
                      item: item,
                      onTapCard: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EventDetail(event: item),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              TextSaparator(
                title: "Berita",
                showMore: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewsPage(),
                    ),
                  );
                },
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: DummyData.events.length,
                itemBuilder: (contex, index) {
                  var item = DummyData.events[index];
                  return CardNews(item: item);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TextSaparator extends StatelessWidget {
  TextSaparator({super.key, this.title, this.showMore});

  String? title;
  VoidCallback? showMore = () {};
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.sp,
        vertical: 15.sp,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$title", style: TextStyle(fontSize: 14.sp)),
          GestureDetector(
            onTap: showMore,
            child: const Text(
              "Lihat Semua",
              style: TextStyle(
                color: Colors.black54,
              ),
            ),
          )
        ],
      ),
    );
  }
}
