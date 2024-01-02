import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../controller/event_controller.dart';
import 'create_event2.dart';

class CreateEventScreen extends StatelessWidget {
  const CreateEventScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final ButtonController controller = Get.put(ButtonController());
    final TicketController ticketController = Get.put(TicketController());
    final screenWidth = MediaQuery.of(context).size.width;
    return Obx(() =>  Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 19,
            ),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff025B8F),
          title: Text(
            'Create Event',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ticket Details',
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff025B8F),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        isSelected.value = true;
                        // if (isSelected.value == false) {
                        //   isSelected.value = true;
                        // }
                      },
                      child: Container(
                        height: 6.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          color: isSelected.value
                              ? const Color(0xff025B8F)
                              : Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Paid',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: isSelected.value
                                  ? Colors.white
                                  : const Color(0xff025B8F),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        // if (isSelected.value == true) {
                        //   isSelected.value = false;
                        // }
                        isSelected.value = false;
                      },
                      child: Container(
                        height: 6.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          color: isSelected.value
                              ? Colors.white
                              : const Color(0xff025B8F),
                        ),
                        child: Center(
                          child: Text(
                            'Free',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: isSelected.value
                                  ? const Color(0xff025B8F)
                                  : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  'Max Participants',
                  style: GoogleFonts.inter(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff025B8F),
                  ),
                ),
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 6.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xff025B8F)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svgs/mynaui_users-group.svg',
                              color: Colors.white,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              controller.count.value.toString(),
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    GestureDetector(
                      onTap: () {
                        controller.increment();
                      },
                      child: CircleAvatar(
                        radius: 3.3.h,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/svgs/+.svg',
                            color: Color(0xff025B8F),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    GestureDetector(
                        onTap: () {
                          controller.decrement();
                        },
                        child: CircleAvatar(
                          radius: 3.3.h,
                          backgroundColor: Colors.white,
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/svgs/-.svg',
                              color: Color(0xff025B8F),
                            ),
                          ),
                        )),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 5.5.h,
                        width: screenWidth / 2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.black),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            'Save Draft',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => CreateEvent2Screen());
                        },
                        child: Container(
                          height: 5.5.h,
                          width: screenWidth / 2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff025B8F),
                          ),
                          child: Center(
                            child: Text(
                              'Next',
                              style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonController extends GetxController {

  var count = 0.obs;

  void increment() {
    count++;
  }

  void decrement() {
    if (count > 0) {
      count--;
    }
  }
}

