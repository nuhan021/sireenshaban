import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

import '../../../../../core/common/widgets/IField.dart';
import '../../../../../routes/app_routes.dart';
import '../../controller/create_package_controller.dart';

class CreatePackage extends StatefulWidget {
  const CreatePackage({super.key});

  @override
  State<CreatePackage> createState() => _CreatePackageState();
}

class _CreatePackageState extends State<CreatePackage> {
  final CreatePackageController controller = Get.put(CreatePackageController());
  final HomeController homeController = Get.find<HomeController>();

  // Theme Constants
  final Color primaryColor = const Color(0xFF1E3A8A);
  final Color backgroundColor = const Color(0xFFF8F9FA);

  DateTime _focusedDay = DateTime.now();
  DateTime _activeDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImagePickerHeader(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader(
                    "Package Details",
                    "Provide basic information about your service",
                  ),
                  16.verticalSpace,
                  _buildFormFields(),
                  24.verticalSpace,
                  _buildSectionHeader(
                    "Select Availability",
                    "Choose dates and add time slots",
                  ),
                  16.verticalSpace,
                  _buildCalendarCard(),
                  24.verticalSpace,
                  _buildTimeSlotHeader(),
                  12.verticalSpace,
                  _buildTimeSlotGrid(),
                  40.verticalSpace,
                  Center(
                    child: TextButton(
                      onPressed: () =>
                          Get.toNamed(AppRoute.vendorProfileInfoMap),
                      child: Text(
                        'Set Location on Map',
                        style: TextStyle(color: primaryColor),
                      ),
                    ),
                  ),

                  20.verticalSpace,
                  _buildSubmitButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text("Create New Package"),
      elevation: 0,
      centerTitle: true,
    );
  }

  Widget _buildImagePickerHeader() {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.pickBannerImageFromGallery(),
        child: Container(
          height: 225.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
          ),
          child: controller.bannerImage.value != null
              ? ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(16.r),
                  ),
                  child: Image.file(
                    File(controller.bannerImage.value!.path),
                    fit: BoxFit.cover,
                  ),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo_outlined,
                      size: 40.sp,
                      color: primaryColor,
                    ),
                    8.verticalSpace,
                    Text(
                      "Upload Banner Image",
                      style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInputLabel("Service Category"),
        Obx(() {
          final categories = homeController.categorys.value?.data ?? [];
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xFFEBEBEB)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                isExpanded: true,
                hint: const Text("Select Category"),
                value: controller.selectedCategoryId.value,
                items: categories.map((category) {
                  return DropdownMenuItem<int>(
                    value: category.id,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (val) => controller.selectedCategoryId.value = val,
              ),
            ),
          );
        }),
        16.verticalSpace,

        // --- Service Group Dropdown ---
        _buildInputLabel("Service Group"),
        Obx(() => _buildDropdownContainer(
          child: DropdownButton<ServicesGroup>(
            isExpanded: true,
            hint: const Text("Select Group"),
            value: controller.selectedServiceGroup.value,
            items: ServicesGroup.values.map((group) {

              // 1. Convert camelCase to spaces: "business And Creative Services"
              String text = group.name.replaceAllMapped(
                  RegExp(r'([A-Z])'),
                      (match) => ' ${match.group(0)}'
              );

              // 2. Capitalize first letter and lowercase the rest: "Business and creative services"
              String formattedText = text[0].toUpperCase() + text.substring(1).toLowerCase();

              return DropdownMenuItem(
                value: group,
                child: Text(formattedText),
              );
            }).toList(),
            onChanged: (val) => controller.selectedServiceGroup.value = val,
          ),
        )),
        16.verticalSpace,

        // --- Venue Type & Shift Selection ---
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputLabel("Venue Type"),
                  Obx(() => _buildDropdownContainer(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: controller.venueType.value,
                      items: ["Indoor", "Outdoor"].map((type) {
                        return DropdownMenuItem(value: type, child: Text(type));
                      }).toList(),
                      onChanged: (val) => controller.venueType.value = val!,
                    ),
                  )),
                ],
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputLabel("Shift"),
                  Obx(() => _buildDropdownContainer(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: controller.shift.value,
                      items: ["Morning", "Evening", "Night"].map((s) {
                        return DropdownMenuItem(value: s, child: Text(s));
                      }).toList(),
                      onChanged: (val) => controller.shift.value = val!,
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
        16.verticalSpace,

        _buildInputLabel("Package Title"),
        IField(
          controller: controller.titleController,
          hintText: 'Enter title',
          filled: true,
          fillColour: Colors.white,
          borderColor: const Color(0xFFEBEBEB),
        ),
        16.verticalSpace,


        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputLabel("Price"),
                  IField(
                    controller: controller.priceController,
                    hintText: '\$0.00',
                    filled: true,
                    fillColour: Colors.white,
                    borderColor: const Color(0xFFEBEBEB),
                  ),
                ],
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInputLabel("Capacity"),
                  IField(
                    controller: controller.capacityController,
                    hintText: '0',
                    filled: true,
                    fillColour: Colors.white,
                    borderColor: const Color(0xFFEBEBEB),
                  ),
                ],
              ),
            ),
          ],
        ),
        16.verticalSpace,

        _buildInputLabel("Description"),
        IField(
          controller: controller.descriptionController,
          hintText: 'Describe your package...',
          filled: true,
          fillColour: Colors.white,
          borderColor: const Color(0xFFEBEBEB),
        ),
      ],
    );
  }

  Widget _buildInputLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, String subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget _buildCalendarCard() {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        rowHeight: 45.h,
        headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
        ),
        selectedDayPredicate: (day) => isSameDay(_activeDay, day),
        onDaySelected: (selectedDay, focusedDay) {
          setState(() {
            _activeDay = selectedDay;
            _focusedDay = focusedDay;
          });
        },
        calendarBuilders: _buildCalendarBuilders(),
        calendarStyle: CalendarStyle(
          selectedDecoration: BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
          todayDecoration: BoxDecoration(
            color: primaryColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  CalendarBuilders _buildCalendarBuilders() {
    return CalendarBuilders(
      markerBuilder: (context, date, events) {
        return Obx(() {
          DateTime dayKey = DateTime(date.year, date.month, date.day);
          if (controller.selectedSlots.containsKey(dayKey)) {
            return Positioned(
              bottom: 4,
              child: Container(
                width: 5.w,
                height: 5.w,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        });
      },
    );
  }

  Widget _buildTimeSlotHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Slots for ${DateFormat('dd MMM').format(_activeDay)}",
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
        ),
        TextButton.icon(
          onPressed: _handleTimePicker,
          icon: Icon(Icons.add, size: 18.sp),
          label: const Text("Add New Slot"),
          style: TextButton.styleFrom(foregroundColor: primaryColor),
        ),
      ],
    );
  }

  Widget _buildTimeSlotGrid() {
    return Obx(() {
      DateTime dayKey = DateTime(
        _activeDay.year,
        _activeDay.month,
        _activeDay.day,
      );
      final currentSelectedTimes = controller.selectedSlots[dayKey] ?? [];

      if (controller.customTimeSlots.isEmpty) {
        return _buildEmptyState();
      }

      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.6,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
        ),
        itemCount: controller.customTimeSlots.length,
        itemBuilder: (context, index) {
          final timeLabel = controller.customTimeSlots[index];
          final isSelected = currentSelectedTimes.contains(timeLabel);

          return Material(
            color: isSelected ? primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            elevation: isSelected ? 4 : 0,
            child: InkWell(
              onLongPress: () => _showDeleteConfirmation(timeLabel),
              onTap: () => controller.toggleSlot(_activeDay, timeLabel),
              borderRadius: BorderRadius.circular(8.r),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  timeLabel,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 13.sp,
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: const Center(
        child: Text("No time slots available. Add one to begin."),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: CustomPrimaryButton(
        text: 'Publish',
        color: AppColors.primaryDeepBlueNormal,
        onPressed: () => controller.submitPackage(),
      ),
    );
  }

  // --- Logic Handlers ---

  Future<void> _handleTimePicker() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      final now = DateTime.now();
      final dt = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      controller.addCustomTime(DateFormat('hh:mm a').format(dt));
    }
  }

  void _showDeleteConfirmation(String time) {
    Get.defaultDialog(
      title: "Delete Slot",
      middleText: "Remove '$time' from available options?",
      textConfirm: "Remove",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        controller.removeTimeSlot(time);
        Get.back();
      },
    );
  }
}

// Helper for consistent dropdown styling
Widget _buildDropdownContainer({required Widget child}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.r),
      border: Border.all(color: const Color(0xFFEBEBEB)),
    ),
    child: DropdownButtonHideUnderline(child: child),
  );
}
