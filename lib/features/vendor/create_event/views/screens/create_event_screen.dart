import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sireenshaban/core/common/widgets/custom_loading.dart';
import 'package:sireenshaban/core/common/widgets/custom_primary_button.dart';
import 'package:sireenshaban/core/utils/constants/colors.dart';
import 'package:sireenshaban/features/customer/home/controller/home_controller.dart';
import '../../../../../core/common/widgets/IField.dart';
import '../../../../../routes/app_routes.dart';
import '../../controller/create_event_controller.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  final CreateEventController controller = Get.put(CreateEventController());
  final HomeController homeController = Get.find<HomeController>();

  final Color primaryColor = const Color(0xFF1E3A8A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(title: const Text("Create New Event"), centerTitle: true),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildImagePicker(),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLabel("Event Category"),
                  _buildCategoryDropdown(),
                  16.verticalSpace,
                  _buildLabel("Event Title"),
                  IField(
                    controller: controller.titleController,
                    hintText: 'Demo Event',
                    filled: true,
                    fillColour: Colors.white,
                    borderColor: const Color(0xFFEBEBEB),
                  ),
                  16.verticalSpace,

                  // Single Date and Time Row
                  Row(
                    children: [
                      Expanded(child: _buildDatePicker()),
                      12.horizontalSpace,
                      Expanded(child: _buildTimePicker()),
                    ],
                  ),
                  16.verticalSpace,

                  _buildLabel("Description"),
                  IField(
                    controller: controller.descriptionController,
                    hintText: 'Tell us about the event',
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
                            _buildLabel("Ticket Price"),
                            IField(
                              controller: controller.ticketPriceController,
                              hintText: '200',
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
                            _buildLabel("Max Attendees"),
                            IField(
                              controller: controller.maxAttendeesController,
                              hintText: '500',
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

                  _buildLabel("Organizer Contact"),
                  IField(
                    controller: controller.contactController,
                    hintText: '880156845698',
                    filled: true,
                    fillColour: Colors.white,
                    borderColor: const Color(0xFFEBEBEB),
                  ),

                  24.verticalSpace,
                  Center(
                    child: TextButton.icon(
                      onPressed: () =>
                          Get.toNamed(AppRoute.vendorProfileInfoMap),
                      icon: const Icon(Icons.map),
                      label: const Text('Select Event Location'),
                    ),
                  ),
                  30.verticalSpace,
                  Obx(() {
                    if (controller.isLoading.value) {
                      return Center(child: CustomLoading());
                    }
                    return CustomPrimaryButton(
                      text: 'Publish Event',
                      color: AppColors.primaryDeepBlueNormal,
                      onPressed: () => controller.submitEvent(),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Event Date"),
        GestureDetector(
          onTap: () async {
            DateTime? picked = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
            );
            if (picked != null) controller.selectedDate.value = picked;
          },
          child: Obx(
            () => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFFEBEBEB)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.selectedDate.value == null
                        ? "Select Date"
                        : DateFormat(
                            'yyyy-MM-dd',
                          ).format(controller.selectedDate.value!),
                    style: TextStyle(
                      color: controller.selectedDate.value == null
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                  const Icon(
                    Icons.calendar_month,
                    size: 20,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Event Time"),
        GestureDetector(
          onTap: () async {
            TimeOfDay? picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (picked != null) controller.selectedTime.value = picked;
          },
          child: Obx(
            () => Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: const Color(0xFFEBEBEB)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    controller.selectedTime.value == null
                        ? "Select Time"
                        : controller.selectedTime.value!.format(context),
                    style: TextStyle(
                      color: controller.selectedTime.value == null
                          ? Colors.grey
                          : Colors.black,
                    ),
                  ),
                  const Icon(Icons.access_time, size: 20, color: Colors.grey),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Obx(() {
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
            items: categories
                .map(
                  (cat) =>
                      DropdownMenuItem(value: cat.id, child: Text(cat.name)),
                )
                .toList(),
            onChanged: (val) => controller.selectedCategoryId.value = val,
          ),
        ),
      );
    });
  }

  Widget _buildImagePicker() {
    return Obx(
      () => GestureDetector(
        onTap: () => controller.pickImage(),
        child: Container(
          height: 225.h,
          width: double.infinity,
          color: Colors.grey[200],
          child: controller.eventImage.value != null
              ? Image.file(
                  File(controller.eventImage.value!.path),
                  fit: BoxFit.cover,
                )
              : const Icon(Icons.add_a_photo, size: 50, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: EdgeInsets.only(bottom: 5.h),
    child: Text(
      text,
      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
    ),
  );
}
