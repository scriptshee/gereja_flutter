import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/models/news_model.dart';

class CardNews extends StatelessWidget {
  CardNews({super.key, required this.item, this.onTapCard});

  final News item;
  VoidCallback? onTapCard;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCard,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: 10.sp,
          vertical: 3.sp,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${item.publishedDate}",
                    style: TextStyle(fontSize: 10.sp),
                  ),
                  Text(
                    "${item.title}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    overflow: TextOverflow
                        .ellipsis, // Ensures the text will have ellipsis if it overflows
                    maxLines: 2, // Limits the text to a maximum of 2 lines
                    softWrap: true, // Enables wrapping
                  ),
                ],
              ),
            ),
            SizedBox(width: 15.sp),
            Container(
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(
                    8.0), // Rounded corners for the border
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    8.0), // Same rounded corners for the image
                child: Image.network(
                  '${item.thumbnail}',
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
