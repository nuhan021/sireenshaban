import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';

class ReviewsCard extends StatelessWidget {
  const ReviewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage("https://img.freepik.com/premium-photo/portrait-beautiful-young-woman_1048944-30416418.jpg?semt=ais_hybrid&w=740&q=80"),
          ),
          title: Text(
            'Floyd Miles',
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.bodyDarkGray
            ),
          ),

          subtitle: Row(
            children: [
              for(int i = 0; i < 5; i++)
                Icon(Icons.star, color: Color(0xFFF0C020), size: 15.h,),
            ],
          ),

          trailing: Text(
            '25 April, 2025',
            style: getTextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.secondaryTealNormal
            )
          ).paddingOnly(top: 20.h),
        ),


        // review

        Text(
          'Lorem ipsum dolor sit amet consectetur. Interdum ac hac nec etiam. Augue etiam ornare eu velit ultrices pharetra. Velit fringilla tellus justo sed et praesent quam praesent in. Scelerisque venenatis leo nunc convallis vel amet faucibus mattis parturient.',
          textAlign: TextAlign.justify,
          style: getTextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryInfoMediumGrayNormal
          ),
        ).paddingOnly(left: 20.w)
      ],
    ).paddingOnly(bottom: 20.h);
  }
}
