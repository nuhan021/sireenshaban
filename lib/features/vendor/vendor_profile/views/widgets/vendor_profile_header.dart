import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/services/storage_service.dart';
import 'package:sireenshaban/core/controllers/user_controller.dart';

import '../../../../../core/utils/constants/colors.dart';

class VendorProfileHeader extends StatelessWidget {
  const VendorProfileHeader({
    super.key,
    required this.coverPhoto,
    required this.profilePhoto,
  });

  final String coverPhoto;
  final String profilePhoto;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // thumbnail image and profile
        SizedBox(
          height: 260.h,
          width: double.maxFinite,
          child: Stack(
            children: [
              // thumbnail
              ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.r),
                  bottomRight: Radius.circular(10.r),
                ),
                child: CachedNetworkImage(
                  imageUrl: coverPhoto,
                  fit: BoxFit.cover,
                  height: 225.h,
                  width: double.maxFinite,
                  placeholder: (context, url) => Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: AppColors.primaryDeepBlueLight,
                      size: 25.h,
                    ),
                  ),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 20.w,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2.w,
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: profilePhoto,
                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 60.r,
                      backgroundImage: imageProvider,
                    ),
                    placeholder: (context, url) => CircleAvatar(
                      radius: 60.r,
                      backgroundColor: Colors.white,
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: AppColors.primaryDeepBlueLight,
                        size: 25.h,
                      ),
                    ),
                    errorWidget: (context, url, error) => CircleAvatar(
                      radius: 60.r,
                      backgroundImage: const AssetImage(_fallbackProfile),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}