import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/components/SimpleCarousel.dart';
import 'package:gereja_flutter/components/card_news.dart';
import 'package:gereja_flutter/const/dummy_data.dart';
import 'package:gereja_flutter/pages/event/event_page.dart';
import 'package:gereja_flutter/pages/news/news_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> listImg = DummyData.imgList;

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
      ),
      body: SafeArea(
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
                itemCount: DummyData.events.length,
                itemBuilder: (contex, index) {
                  var item = DummyData.events[index];
                  return CardNews(
                    item: item,
                    onTapCard: () {},
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
