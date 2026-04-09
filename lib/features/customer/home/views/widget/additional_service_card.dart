import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';

class AdditionalServiceCard extends StatelessWidget {
  const AdditionalServiceCard({
    super.key,
    required this.img,
    required this.title,
    required this.onPressed,
    this.isHorizontal = false,
  });

  final String img;
  final String title;
  final VoidCallback onPressed;
  final bool isHorizontal;

  @override
  Widget build(BuildContext context) {
    return isHorizontal ? _buildHorizontalCard() : _buildVerticalCard();
  }

  Widget _buildHorizontalCard() {
    return GestureDetector(
      onTap: onPressed,
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFE9EAEC),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  offset: const Offset(0, 3),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: (img.isEmpty)
                  ? const Icon(Icons.image_not_supported_outlined,
                      color: Colors.grey)
                  : CachedNetworkImage(
                      imageUrl: img,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: AppColors.primaryDeepBlueLight,
                          size: 25,
                        ),
                      ),
                      errorWidget: (context, url, error) {
                        debugPrint(
                            'IMAGE LOAD FAILED -> url="$url" error=$error');
                        return const Icon(Icons.broken_image_outlined,
                            color: Colors.grey);
                      },
                    ),
            ),
          ),
          const SizedBox(width: 7),
          Text(
            title,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryInfoMediumGrayDarker,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalCard() {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            width: 60,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFFE9EAEC),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  offset: const Offset(0, 3),
                  blurRadius: 10,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: (img.isEmpty)
                  ? const Icon(Icons.image_not_supported_outlined,
                      color: Colors.grey)
                  : CachedNetworkImage(
                      imageUrl: img,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: LoadingAnimationWidget.staggeredDotsWave(
                          color: AppColors.primaryDeepBlueLight,
                          size: 25,
                        ),
                      ),
                      errorWidget: (context, url, error) {
                        debugPrint(
                            'IMAGE LOAD FAILED -> url="$url" error=$error');
                        return const Icon(Icons.broken_image_outlined,
                            color: Colors.grey);
                      },
                    ),
            ),
          ),
          const SizedBox(height: 7),
          Text(
            title,
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.secondaryInfoMediumGrayDarker,
            ),
          ),
        ],
      ),
    );
  }
}
