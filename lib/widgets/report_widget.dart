import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../uitilities/colors.dart';

class ReportWidget extends StatefulWidget {
  const ReportWidget({super.key});

  @override
  State<ReportWidget> createState() => _ReportWidgetState();
}

class _ReportWidgetState extends State<ReportWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.19,
      height: MediaQuery.of(context).size.height * 1.00,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Patient:',
                  style: GoogleFonts.urbanist(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  'JennyWilson:',
                  style: GoogleFonts.urbanist(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(
              height: 20,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'HPI',
                  style: GoogleFonts.urbanist(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 24,
                  color: Colors.black.withOpacity(0.50),
                )
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'The patient is a 32 years old presenting\ntoday for : Cough.',
              style: GoogleFonts.urbanist(
                  color: Colors.black.withOpacity(0.60),
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 3,
            ),
            const TextField(
              decoration: InputDecoration(
                  fillColor: textfieldColor,
                  filled: true,
                  border: InputBorder.none),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              height: 10,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'PE',
                  style: GoogleFonts.urbanist(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 24,
                  color: Colors.black.withOpacity(0.50),
                )
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            const TextField(
              decoration: InputDecoration(
                  fillColor: textfieldColor,
                  filled: true,
                  border: InputBorder.none),
            ),
            const SizedBox(
              height: 60,
            ),
            const Divider(
              height: 10,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'A/P',
                  style: GoogleFonts.urbanist(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 24,
                  color: Colors.black.withOpacity(0.50),
                )
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            const TextField(
              decoration: InputDecoration(
                  fillColor: textfieldColor,
                  filled: true,
                  border: InputBorder.none),
            ),
          ],
        ),
      ),
    );
  }
}
