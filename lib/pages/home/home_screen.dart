import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/components/SimpleCarousel.dart';
import 'package:gereja_flutter/components/card_event.dart';
import 'package:gereja_flutter/components/card_news.dart';
import 'package:gereja_flutter/const/dummy_data.dart';
import 'package:gereja_flutter/models/event_model.dart';
import 'package:gereja_flutter/models/news_model.dart';
import 'package:gereja_flutter/pages/event/event_detail.dart';
import 'package:gereja_flutter/pages/event/event_page.dart';
import 'package:gereja_flutter/pages/news/news_detail.dart';
import 'package:gereja_flutter/pages/news/news_page.dart';
import 'package:gereja_flutter/services/event_services.dart';
import 'package:gereja_flutter/services/news_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> listImg = DummyData.imgList;
  final apiEvent = EvenServices();
  final apiNews = NewsServices();

  List<EventModel> event = [];
  List<News> news = [];

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

  Future<void> fetchNews() async {
    final resp = await apiNews.get(context);
    if (resp.statusCode == 200) {
      List<dynamic> dataresp = resp.data['data'] as List;
      List<News> data = dataresp.map((e) => News.fromJson(e)).toList();
      setState(() {
        news = data;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchEvent();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            itemCount: news.length,
            itemBuilder: (contex, index) {
              News item = news[index];
              return CardNews(
                item: item,
                onTapCard: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsDetail(event: item),
                    ),
                  );
                },
              );
            },
          ),
        ],
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
