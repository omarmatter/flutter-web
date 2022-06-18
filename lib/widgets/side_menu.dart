import 'package:cloud_hospital/apis/auth_apis.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../constants/controllers.dart';
import '../constants/style.dart';
import '../helpers/reponsiveness.dart';
import '../routing/routes.dart';
import '../routing/user_type_list.dart';
import '../services/sp_helper.dart';
import 'custom_text.dart';
import 'side_menu_item.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({ Key key }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery
        .of(context)
        .size
        .width;

    return Container(
      color: light,
      child: ListView(
        children: [
          if(ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: _width / 48),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "لوحة التحكم",
                        size: 20,
                        weight: FontWeight.bold,
                        color: active,
                      ),
                    ),
                    SizedBox(width: _width / 48),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          Divider(color: lightGrey.withOpacity(.1),),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: SPHelper.spHelper.getUserType() == 'admin'
                ? sideMenuItemRoutes
                .map((item) =>
                SideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (!menuController.isActive(item.name)) {
                        menuController.changeActiveItemTo(item.name);
                        if (ResponsiveWidget.isSmallScreen(context))
                          Get.back();
                        navigationController.navigateTo(item.route);
                      }
                      if (item.route == logoutPageRoute) {
                        AuthApis.authApis.logout();
                        menuController.changeActiveItemTo(
                            overviewPageDisplayName);
                      }
                    }))
                .toList()
                : SPHelper.spHelper.getUserType() == 'patient'
                ? PationtsideMenuItemRoutes
                .map((item) =>
                SideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (!menuController.isActive(item.name)) {
                        menuController.changeActiveItemTo(item.name);
                        if (ResponsiveWidget.isSmallScreen(context))
                          Get.back();
                        navigationController.navigateTo(item.route);
                      }
                      if (item.route == logoutPageRoute) {
                        AuthApis.authApis.logout();
                        menuController.changeActiveItemTo(
                            overviewPageDisplayName);
                      }
                    }))
                .toList():DoctorsideMenuItemRoutes
                .map((item) => SideMenuItem(
                itemName: item.name,
                onTap: ()  {

                  if (!menuController.isActive(item.name)) {
                    menuController.changeActiveItemTo(item.name);
                    if(ResponsiveWidget.isSmallScreen(context))
                      Get.back();
                    navigationController.navigateTo(item.route);
                  }
                  if(item.route == logoutPageRoute){
                    AuthApis.authApis.logout();
                    menuController.changeActiveItemTo(overviewPageDisplayName);
                  }
                }))
                .toList(),
          )
        ],
      ),
    );
  }
}