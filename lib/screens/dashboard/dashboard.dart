import 'package:aimedscribble/widgets/Client_widget.dart';
import 'package:aimedscribble/widgets/details_widget.dart';
import 'package:aimedscribble/widgets/liveStream_widget.dart';
import 'package:aimedscribble/widgets/report_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../uitilities/colors.dart';
import '../../widgets/text_field_input.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 225, 225, 225),
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Image.asset("assets/side_menu.png"),
          title: const Row(
            children: [
              Text(
                "Your work",
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "Projects",
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              )
            ],
          ),
          actions: [
            Image.asset("assets/tittle.png"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                width: screenWidth * 0.35,
                child: TextFieldInput(
                  iconPath: "assets/search.png",
                  hintText: 'Search',
                  textInputType: TextInputType.text,
                  textEditingController: _searchController,
                  isSearch: true,
                ),
              ),
            ),
            Image.asset("assets/help.png"),
            Image.asset("assets/notification.png"),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 18),
              child: Text(
                "Dr.Jhon",
                style: TextStyle(
                  color: textColor,
                  fontSize: 13,
                ),
              ),
            ),
            Image.asset("assets/profile.png"),
          ],
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 1.00,
          width: double.infinity,
          child: Padding(
              padding: EdgeInsets.only(top: 16, left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (Get.width >= 600) ClientWidget() else Container(),
                  10.widthBox,
                  if (Get.width >= 800) ReportWidget() else Container(),
                  10.widthBox,
                  Expanded(child: DetailsWidget()),
                  10.widthBox,
                  Expanded(child: LiveStreamWidget()),
                ],
              )),
        ));
  }
}
