import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget translationSection(
  BuildContext context, {
  required String title,
  required String translation,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.notoSerif(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          color: Colors.deepOrange.shade700,
        ),
      ),
      SizedBox(
        height: 10.h,
      ),
      Container(
        padding: EdgeInsets.all(12.sp),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.deepOrange.shade200,
            width: 1,
          ),
        ),
        child: Text(
          translation,
          style: GoogleFonts.notoSerif(
            fontSize: 18.sp,
            color: Colors.brown.shade900,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.justify,
        ),
      ),
    ],
  );
}
