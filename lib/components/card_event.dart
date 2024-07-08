import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gereja_flutter/models/event_model.dart';

class CardEvent extends StatelessWidget {
  CardEvent({super.key, required this.item, this.onTapCard});

  final EventModel item;
  VoidCallback? onTapCard;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapCard,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10.sp,
          vertical: 7.sp,
        ),
        child: Row(
          children: [
            ClipRect(
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                '${item.thumbnail}',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 15.sp),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${item.createdAt}",
                  style: TextStyle(fontSize: 11.sp),
                ),
                Text(
                  "${item.title}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Mulai: ${item.startDatetime} - Sampai: ${item.endDatetime}",
                  style: TextStyle(fontSize: 10.sp),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
