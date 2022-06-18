import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../controllers/dashboard_controller.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';
import 'widgets/available_drivers_table.dart';
import 'widgets/overview_cards_large.dart';
import 'widgets/overview_cards_medium.dart';
import 'widgets/overview_cards_small.dart';
import 'widgets/revenue_section_large.dart';
import 'widgets/revenue_section_small.dart';

class OverviewPage extends StatelessWidget {
  DashboardController dashboardController = Get.find();

  @override
  Widget build(BuildContext context) {
    var doctor = dashboardController.getAllDoctorModelData.value.data;
    var patent = dashboardController.getAllPationtModelData.value.data;
    var specialties = dashboardController.getDepartmentDoctorModelData.value.data;
    return Container(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(
                        top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: [
                if (ResponsiveWidget.isLargeScreen(context) ||
                    ResponsiveWidget.isMediumScreen(context))
                  if (ResponsiveWidget.isCustomSize(context))
                    OverviewCardsMediumScreen()
                  else
                    OverviewCardsLargeScreen()
                else
                  OverviewCardsSmallScreen(),
                if (!ResponsiveWidget.isSmallScreen(context))
                  RevenueSectionLarge()
                else
                  RevenueSectionSmall(),

                  AvailableDriversTable(),

            ],
          ),
              )
        ],
      ),
    );
  }
}
