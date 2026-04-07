import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
      dominantColor =
          paletteGenerator.dominantColor?.color ??
          AppColors.primaryDeepBlueNormal;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundSoftGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: CachedNetworkImage(
              imageUrl: widget.bannerImage,
              fit: BoxFit.cover,
              height: 185,
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

          const SizedBox(height: 10),

          // title
          Text(
            widget.title,
            style: getTextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.bodyDarkGray,
            ),
          ),

          const SizedBox(height: 6),

          // date
          Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: AppColors.secondaryInfoMediumGrayNormal,
                size: 18,
              ),
              const SizedBox(width: 5),
              Text(
                widget.date,
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondaryInfoMediumGrayNormal,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // location
          Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                color: AppColors.secondaryInfoMediumGrayNormal,
                size: 18,
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  widget.location,
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

          const SizedBox(height: 6),

          // ticket price
          Row(
            children: [
              const Icon(
                Icons.airplane_ticket_rounded,
                color: AppColors.accentNormal,
                size: 18,
              ),
              const SizedBox(width: 5),
              Text(
                "\$ ${widget.ticketPrice}/ per ticket",
                style: getTextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.accentNormal,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          CustomPrimaryButton(
            text: "View details",
            color: dominantColor ?? AppColors.primaryDeepBlueNormal,
            height: 48,
            fontSize: 16,
            onPressed: () => AppHelperFunctions.navigateToScreen(
              context,
              CommunityEventBookingScreen(
                id: 1,
                image: widget.bannerImage,
                title: widget.title,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
