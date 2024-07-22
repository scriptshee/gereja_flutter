import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/components/card_news.dart';
import 'package:gereja_flutter/models/news_model.dart';
import 'package:gereja_flutter/pages/news/news_detail.dart';
import 'package:gereja_flutter/services/news_services.dart';
import 'package:loader_overlay/loader_overlay.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final apiNews = NewsServices();
  List<News> news = [];

  Future<void> fetchNews() async {
    context.loaderOverlay.show();
    final resp = await apiNews.get(context);
    if (resp.statusCode == 200) {
      List<dynamic> dataresp = resp.data['data'] as List;
      List<News> data = dataresp.map((e) => News.fromJson(e)).toList();
      setState(() {
        news = data;
      });
      context.loaderOverlay.hide();
    }
    context.loaderOverlay.hide();
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Berita "),
      ),
      body: RefreshIndicator(
        onRefresh: () => fetchNews(),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: news.length,
              itemBuilder: (context, index) {
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
          ),
        ),
      ),
    );
  }
}
