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
                    "${item.createdAt}",
                    style: TextStyle(fontSize: 10.sp),
                  ),
                  Text(
                    "${item.title}",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "Mulai: ${item.startDatetime} - Sampai: ${item.endDatetime}",
                    style: TextStyle(fontSize: 10.sp),
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
