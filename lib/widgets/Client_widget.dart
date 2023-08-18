import 'package:aimedscribble/uitilities/clientData.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../uitilities/colors.dart';

class ClientWidget extends StatefulWidget {
  const ClientWidget({super.key});

  @override
  State<ClientWidget> createState() => _ClientWidgetState();
}

class _ClientWidgetState extends State<ClientWidget> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.18,
        height: MediaQuery.of(context).size.height * 1.00,
        color: Colors.white,
        child: Column(
          children: [
            // Blue App Bar work
            Container(
              height: 80,
              width: double.infinity,
              color: blueColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6)
                    .copyWith(top: 0, bottom: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Date Time Work
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${DateFormat('EEEE').format(selectedDate)},${DateFormat(' dd/MM/yyyy').format(selectedDate)}',
                              style: GoogleFonts.urbanist(
                                  fontSize: 14,
                                  letterSpacing: 1,
                                  color: primaryColor,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.keyboard_arrow_down_outlined,
                              color: primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                    // TabBar work
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: primaryColor,
                        ),
                        Icon(
                          Icons.person_add_alt,
                          color: primaryColor,
                        ),
                        Icon(
                          Icons.file_download_outlined,
                          color: primaryColor,
                        ),
                        Icon(
                          Icons.calendar_month_outlined,
                          color: primaryColor,
                        ),
                        Icon(
                          Icons.wifi_protected_setup_sharp,
                          color: primaryColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),

            // Client Data Work
            Expanded(
                child: ListView.builder(
              itemCount: clientData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(clientData[index]['image']),
                  ),
                  title: Text(
                    clientData[index]['name'],
                    style: GoogleFonts.urbanist(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    clientData[index]['time'],
                    style: GoogleFonts.urbanist(
                        color: Colors.black.withOpacity(0.50),
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing: Container(
                    alignment: Alignment.center,
                    height: 29,
                    width: 61,
                    decoration: BoxDecoration(
                        color: blueColor,
                        borderRadius: BorderRadius.circular(24)),
                    child: Text(
                      'View',
                      style: GoogleFonts.urbanist(
                          color: primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                );
              },
            ))
          ],
        ));
  }
}
