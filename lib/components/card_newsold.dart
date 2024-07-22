import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/models/news_model.dart';

class CardNews extends StatelessWidget {
  CardNews({
    super.key,
    required this.news,
    this.onTapCard,
  });

  News news;
  VoidCallback? onTapCard;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCard,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20.sp,
          vertical: 7.sp,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${news.publishedDate}",
                  style: TextStyle(fontSize: 11.sp),
                ),
                Text(
                  "${news.title}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black12)),
              child: ClipRect(
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  '${news.thumbnail}',
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
