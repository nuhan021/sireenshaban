import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sireenshaban/core/utils/logging/logger.dart';
import 'package:sireenshaban/features/customer/confirm_booking/views/controller/confirm_booking_controller.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../../core/common/styles/global_text_style.dart';
import '../../../../../core/utils/constants/colors.dart';
import '../../../home/model/packages_model.dart';

class SelectTimeAndDateScreen extends StatefulWidget {
  SelectTimeAndDateScreen({
    super.key,
    required this.availableDates,
    required this.serviceDuration,
  });

  final List<AvailableDate> availableDates;
  final int serviceDuration;

  final ConfirmBookingController confirmBookingController = Get.put(
    ConfirmBookingController(),
  );

  @override
  State<SelectTimeAndDateScreen> createState() =>
      _SelectTimeAndDateScreenState();
}

class _SelectTimeAndDateScreenState extends State<SelectTimeAndDateScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TimeSlot? _selectedTimeSlot;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // প্রথম available date select করুন
    if (widget.availableDates.isNotEmpty) {
      _selectedDay = widget.availableDates.first.date;
      _focusedDay = widget.availableDates.first.date;
    }
  }

  // Check করুন কোন তারিখ available কিনা
  bool _isDateAvailable(DateTime day) {
    return widget.availableDates.any(
      (availableDate) => isSameDay(availableDate.date, day),
    );
  }

  // Selected date এর time slots পান
  List<TimeSlot> _getTimeSlotsForSelectedDate() {
    if (_selectedDay == null) return [];

    final dateInfo = widget.availableDates.firstWhere(
      (d) => isSameDay(d.date, _selectedDay!),
      orElse: () => AvailableDate(
        id: 0,
        packageId: 0,
        eventId: null,
        date: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        timeSlots: [],
      ),
    );

    return dateInfo.timeSlots;
  }

  // Booking confirm করুন
  Future<void> _confirmBooking() async {
    if (_selectedDay == null || _selectedTimeSlot == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please select date and time')));
      return;
    }

    setState(() => _isLoading = true);

    // এখানে আপনার API call করুন
    await Future.delayed(Duration(seconds: 1));

    AppLoggerHelper.debug(_selectedTimeSlot!.id.toString());

    widget.confirmBookingController.timeSlotId = _selectedTimeSlot!.id;

    // Success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Booking confirmed for ${DateFormat('MMM dd, yyyy').format(_selectedDay!)} at ${_selectedTimeSlot!.time}',
        ),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_outlined, color: Colors.black),
        ),
        title: Text(
          'Select Date & Time',
          style: getTextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.bodyDarkGray,
          ),
        ),
      ),
      body: Column(
        children: [
          // Calendar
          Container(
            margin: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 8,
                ),
              ],
            ),
            child: TableCalendar(
              firstDay: widget.availableDates.first.date,
              lastDay: widget.availableDates.last.date,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              enabledDayPredicate: (day) => _isDateAvailable(day),
              onDaySelected: (selectedDay, focusedDay) {
                if (_isDateAvailable(selectedDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _selectedTimeSlot = null; // Reset time selection
                  });
                }
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: AppColors.primaryDeepBlueNormal,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppColors.primaryDeepBlueNormal.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                disabledDecoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                disabledTextStyle: TextStyle(color: Colors.grey),
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextStyle: getTextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.bodyDarkGray,
                ),
              ),
            ),
          ),

          // Time Slots Section
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Time Slots',
                    style: getTextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.bodyDarkGray,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: _selectedDay == null
                        ? Center(
                            child: Text(
                              'Please select a date',
                              style: getTextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        : _buildTimeSlotsList(),
                  ),
                ],
              ),
            ),
          ),

          // Confirm Button
          Container(
            padding: EdgeInsets.all(16.w),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _confirmBooking,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryDeepBlueNormal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'Confirm Booking',
                        style: getTextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlotsList() {
    final timeSlots = _getTimeSlotsForSelectedDate();

    if (timeSlots.isEmpty) {
      return Center(
        child: Text(
          'No time slots available',
          style: getTextStyle(fontSize: 14.sp, color: Colors.grey),
        ),
      );
    }

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
        childAspectRatio: 2.5,
      ),
      itemCount: timeSlots.length,
      itemBuilder: (context, index) {
        final slot = timeSlots[index];
        final isSelected = _selectedTimeSlot?.id == slot.id;
        final isBooked = slot.isBooked == 1;

        return InkWell(
          onTap: isBooked
              ? null
              : () {
                  setState(() {
                    _selectedTimeSlot = slot;
                  });
                },
          child: Container(
            decoration: BoxDecoration(
              color: isBooked
                  ? Colors.grey.shade300
                  : isSelected
                  ? AppColors.primaryDeepBlueNormal
                  : Color(0xFFD1D3D8),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryDeepBlueNormal
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    slot.time,
                    style: getTextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: isBooked
                          ? Colors.grey.shade600
                          : isSelected
                          ? Colors.white
                          : AppColors.bodyDarkGray,
                    ),
                  ),
                  if (isBooked)
                    Text(
                      'Booked',
                      style: getTextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
