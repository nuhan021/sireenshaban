import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/core/utils/helpers/app_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sireenshaban/features/customer/community_event_booking/views/screens/community_event_booking_screen.dart';

import '../../../../../core/common/styles/global_text_style.dart';

class CommunityEventsCard extends StatelessWidget {
  const CommunityEventsCard({
    super.key,
    required this.id,
    required this.image,
    required this.title,
    required this.date,
    required this.location,
    this.isFromVendor = false,
  });

  final int id;
  final String image;
  final String title;
  final String date;
  final String location;
  final bool? isFromVendor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppHelperFunctions.navigateToScreen(
        context,
        CommunityEventBookingScreen(
          id: id,
          image: image,
          title: title,
          isFromVendor: isFromVendor,
        ),
      ),
      child: Card(
        child: Container(
          width: 261,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.cardBackgroundSoftGray,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.primaryDeepBlueLight),
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // thumbnail image
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: CachedNetworkImage(
                  imageUrl: image,
                  fit: BoxFit.cover,
                  height: 187,
                  width: double.maxFinite,
                  placeholder: (context, url) => Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.primaryDeepBlueLight,
                      size: 25,
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),

              const SizedBox(height: 8),

              // title
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: getTextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondaryInfoMediumGrayDarker,
                ),
              ),

              const SizedBox(height: 4),

              // date
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.secondaryInfoMediumGrayNormal,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    date,
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.secondaryInfoMediumGrayNormal,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              // location
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    color: AppColors.secondaryInfoMediumGrayNormal,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: Text(
                      location,
                      overflow: TextOverflow.ellipsis,
                      style: getTextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.secondaryAquaNormal,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ).paddingOnly(left: 20),
    );
  }
}
