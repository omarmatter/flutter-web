import 'package:flutter/material.dart';

import 'info_card.dart';
import 'package:get/get.dart';

import '../../../controllers/dashboard_controller.dart';

class OverviewCardsMediumScreen extends StatelessWidget {
  DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            InfoCard(
              title: "عدد الأطباء",
              value: '5',
              onTap: () {},
              topColor: Colors.orange,
            ),
            SizedBox(
              width: _width / 64,
            ),
            InfoCard(
              title: "عدد المرضى",
              value: '11',
              topColor: Colors.lightGreen,
              onTap: () {},
            ),
          ],
        ),
        SizedBox(
          height: _width / 64,
        ),
        Row(
          children: [
            InfoCard(
              title: "عدد تخصصات الأطباء",
              value: '10',
              topColor: Colors.redAccent,
              onTap: () {},
            ),
            // SizedBox(
            //   width: _width / 64,
            // ),
            // InfoCard(
            //   title: "Scheduled deliveries",
            //   value: "32",
            //   onTap: () {},
            // ),
          ],
        ),
      ],
    );
  }
}
