import 'package:flutter/material.dart';
import 'info_card_small.dart';
import 'package:get/get.dart';
import '../../../controllers/dashboard_controller.dart';

class OverviewCardsSmallScreen extends StatelessWidget {
  DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
            title: "عدد الأطباء",
            value: '5',
            onTap: () {},
            isActive: true,
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "عدد المرضى",
            value: '11',
            onTap: () {},
          ),
          SizedBox(
            height: _width / 64,
          ),
          InfoCardSmall(
            title: "عدد تخصصات الأطباء",
            value: '10',
            onTap: () {},
          ),
          // SizedBox(
          //   height: _width / 64,
          // ),
          // InfoCardSmall(
          //   title: "Scheduled deliveries",
          //   value: "32",
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}
