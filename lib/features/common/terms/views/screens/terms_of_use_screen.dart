import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/styles/global_text_style.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF9FAFB),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Terms of Use',
          style: getTextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.bodyDarkGray,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('1. Acceptance of Terms'),
            _sectionBody(
              'By accessing or using The Community List application, you agree to be bound by these Terms of Use. '
              'If you do not agree to these terms, please do not use the application.',
            ),
            _sectionTitle('2. User-Generated Content Policy'),
            _sectionBody(
              'The Community List allows users to share content, communicate with service providers, and engage with the community. '
              'By using these features, you agree to the following:',
            ),
            _bulletPoint('You will not post, share, or transmit any content that is offensive, abusive, harassing, threatening, defamatory, obscene, or otherwise objectionable.'),
            _bulletPoint('You will not use the platform to bully, intimidate, or harass other users.'),
            _bulletPoint('You will not share content that promotes violence, discrimination, or illegal activities.'),
            _bulletPoint('You will not upload spam, misleading content, or unauthorized advertisements.'),
            _sectionTitle('3. Zero Tolerance for Objectionable Content'),
            _sectionBody(
              'The Community List maintains a strict zero-tolerance policy for objectionable content and abusive behavior. '
              'Any user found to be in violation of this policy will have their content removed and may be permanently banned from the platform.',
            ),
            _sectionTitle('4. Reporting & Blocking'),
            _sectionBody(
              'Users have the ability to:',
            ),
            _bulletPoint('Report objectionable content or abusive users through the in-app reporting feature.'),
            _bulletPoint('Block abusive users to prevent further communication. Blocked users will be hidden from your feed immediately.'),
            _bulletPoint('All reports are reviewed by our team within 24 hours. Offending content will be removed, and the responsible user may be ejected from the platform.'),
            _sectionTitle('5. Content Moderation'),
            _sectionBody(
              'The Community List employs content filtering mechanisms to detect and prevent objectionable content. '
              'However, no automated system is perfect. We rely on our community to report content that violates these terms.',
            ),
            _sectionTitle('6. Account Deletion'),
            _sectionBody(
              'You may delete your account at any time from the Profile section of the app. '
              'Account deletion is permanent and will remove all your data from our platform. '
              'This action cannot be undone.',
            ),
            _sectionTitle('7. Privacy'),
            _sectionBody(
              'Your use of The Community List is also governed by our Privacy Policy. '
              'We collect and use your data only as necessary to provide our services.',
            ),
            _sectionTitle('8. Changes to Terms'),
            _sectionBody(
              'We reserve the right to update these Terms of Use at any time. '
              'Continued use of the application after changes constitutes acceptance of the revised terms.',
            ),
            _sectionTitle('9. Contact'),
            _sectionBody(
              'If you have questions or concerns about these Terms of Use, please contact us through the app or via email.',
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 8.h),
      child: Text(
        title,
        style: getTextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppColors.bodyDarkGray,
        ),
      ),
    );
  }

  Widget _sectionBody(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: getTextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: AppColors.bodyDarkGray,
        ),
      ),
    );
  }

  Widget _bulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: getTextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: AppColors.bodyDarkGray,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: getTextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.bodyDarkGray,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
