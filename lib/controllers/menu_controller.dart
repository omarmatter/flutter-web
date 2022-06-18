import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/style.dart';
import '../routing/routes.dart';
import '../widgets/custom_image.dart';

class MenuController extends GetxController {
  static MenuController instance = Get.find();
  var activeItem = overviewPageDisplayName.obs;

  var hoverItem = "".obs;

  changeActiveItemTo(String itemName) {
    activeItem.value = itemName;
  }

  onHover(String itemName) {
    if (!isActive(itemName)) hoverItem.value = itemName;
  }

  isHovering(String itemName) => hoverItem.value == itemName;

  isActive(String itemName) => activeItem.value == itemName;

  Widget returnIconFor(String itemName) {
    switch (itemName) {
      case overviewPageDisplayName:
        return _customIcon('statistics', itemName);
      case driversPageDisplayName:
        return _customIcon('doctor', itemName);
      case clientsPageDisplayName:
        return _customIcon('Patient', itemName);
      case authenticationPageDisplayName:
        return _customIcon('logout', itemName);
      case specialtiesDisplayName:
        return _customIcon('statistics', itemName);
      default:
        return _customIcon('logout', itemName);
    }
  }

  Widget _customIcon(String iconName, String itemName) {
    if (isActive(itemName)) return CustomSvgImage(imageName: iconName, color: dark);

    return CustomSvgImage(
     imageName: iconName,
      color: isHovering(itemName) ? dark : lightGrey,
    );
  }
}
