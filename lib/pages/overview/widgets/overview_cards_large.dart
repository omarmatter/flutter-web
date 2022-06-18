import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/dashboard_controller.dart';
import 'info_card.dart';


class OverviewCardsLargeScreen extends StatelessWidget {
DashboardController dashboardController = Get.find();
  @override
  Widget build(BuildContext context) {

   double _width = MediaQuery.of(context).size.width;

    return  Row(
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
                  onTap: () {},
                  topColor: Colors.lightGreen,

                ),
                SizedBox(
                  width: _width / 64,
                ),
                InfoCard(
                  title: "عدد تخصصات الأطباء",
                  value: '10',
                  onTap: () {},
                  topColor: Colors.redAccent,

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
            );
  }
}