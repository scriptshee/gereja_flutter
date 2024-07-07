import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardNews extends StatelessWidget {
  CardNews({super.key, required this.item, this.onTapCard});

  final item;
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
            ClipOval(
              child: Image.network(
                'https://via.placeholder.com/150',
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
                  "${item['created_at']}",
                  style: TextStyle(fontSize: 11.sp),
                ),
                Text(
                  "${item['label']}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
