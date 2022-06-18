import 'package:cloud_hospital/constants/style.dart';
import 'package:cloud_hospital/controllers/app_controller.dart';
import 'package:cloud_hospital/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'custom_text.dart';

dialogShow(BuildContext context,Widget dropDownDoctorwidget) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          content: Builder(
            builder: (context) {
              return SizedBox(
                height: 268,
                width: 300,
                child: GetBuilder<AppController>(
                  init: AppController(),
                  builder: (controller) {
                    return Column(
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(),
                            const CustomText(
                                text: 'حذف عميل',
                                size: 18,
                                color: primaryColor),
                            IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(Icons.close_outlined)),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        dropDownDoctorwidget,
                        const SizedBox(
                          height: 15,
                        ),
                        CustomTextFormField(
                          controller: controller.timeController,
                          hint: '',
                          onTap: (){controller.selectTime(context);},
                        ),
                        const SizedBox(
                          height: 15,
                        ),

                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ));
}
