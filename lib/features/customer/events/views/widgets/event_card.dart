import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';

import '../../../../../core/utils/helpers/app_helper.dart';
import '../../../community_event_booking/views/screens/community_event_booking_screen.dart';

class EventCard extends StatefulWidget {
  const EventCard({
    super.key,
    required this.bannerImage,
    required this.title,
    required this.date,
    required this.location,
    required this.ticketPrice,
  });

  final String bannerImage;
  final String title;
  final String date;
  final String location;
  final String ticketPrice;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  Color? dominantColor;

  @override
  void initState() {
    super.initState();
    _updatePalette();
  }

  Future<void> _updatePalette() async {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
      NetworkImage(widget.bannerImage),
      size: const Size(200, 100),
      maximumColorCount: 10,
    );

    setState(() {
      dominantColor = paletteGenerator.dominantColor?.color ?? AppColors.primaryDeepBlueNormal;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 390.h,
      width: double.maxFinite,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundSoftGray,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          ClipRRect(
            borderRadius: BorderRadius.circular(7.r),
            child: CachedNetworkImage(
              imageUrl: widget.bannerImage,
              fit: BoxFit.cover,
              height: 185.h,
              width: double.maxFinite,
              placeholder: (context, url) => Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: AppColors.primaryDeepBlueLight,
                  size: 25.h,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),

          // title
          Text(
            widget.title,
            style: getTextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.bodyDarkGray,
            ),
          ),

          // date
          Row(
            children: [
              Icon(
                Icons.calendar_month_outlined,
                color: AppColors.secondaryInfoMediumGrayNormal,
              ),
              5.horizontalSpace,
              Text(
                widget.date,
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryInfoMediumGrayNormal,
                ),
              ),
            ],
          ),

          // location
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.secondaryInfoMediumGrayNormal,
              ),

              5.horizontalSpace,
              Text(
                widget.location,
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryAquaNormal,
                ),
              ),
            ],
          ),

          // ticket price
          Row(
            children: [
              Icon(
                Icons.airplane_ticket_rounded,
                color: AppColors.accentNormal,
              ),

              5.horizontalSpace,
              Text(
                "\$ ${widget.ticketPrice}/ per ticket",
                style: getTextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.accentNormal,
                ),
              ),
            ],
          ),

          CustomPrimaryButton(
            text: "View details",
            color: dominantColor ?? AppColors.primaryDeepBlueNormal,
            onPressed: () => AppHelperFunctions.navigateToScreen(context, CommunityEventBookingScreen(id: 1,image: widget.bannerImage, title: widget.title,)),
          )
        ],
      ),
    );
  }
}
