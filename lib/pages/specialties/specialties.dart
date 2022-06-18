import 'package:cloud_hospital/apis/dashboard_apis.dart';
import 'package:cloud_hospital/constants/style.dart';
import 'package:cloud_hospital/controllers/auth_controller.dart';
import 'package:cloud_hospital/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../constants/controllers.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_form_field.dart';
import 'widget/specialties_table.dart';

class Specialties extends StatefulWidget {
  @override
  State<Specialties> createState() => _SpecialtiesState();
}

class _SpecialtiesState extends State<Specialties> {
  AuthController authController = Get.find();
  DashboardController dashboardController = Get.find();

  TextEditingController spController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
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
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Form(
                          key: _formKey,
                          child: AlertDialog(
                            title: Text('إضافة تخصص'),
                            content: Container(
                              child: CustomTextFormField(
                                suffixIcon: Icons.mail_outline,
                                hint: 'التخصص',
                                onSaved: dashboardController.setSpecialties,
                                validator:
                                    dashboardController.validationSpecialties,
                                // controller:spController ,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  _formKey.currentState.save();
                                  print(dashboardController.specialties);
                                  if (_formKey.currentState.validate()) {
                                    DashboardApis.dashboardApis.addSpecialties(
                                        dashboardController.specialties);
                                  }
                                },
                                child: const CustomText(
                                  text: "إضافة",
                                  color: primaryColor,
                                  size: 16,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: const CustomText(
                                  text: "إلغاء",
                                  size: 16,
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: active, width: .5),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Center(
                      child: CustomText(
                        text: "إضافة",
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [SpecialtiesTable()],
            ),
          )),
        ],
      ),
    );
  }

  showMyDialog(BuildContext contex) async {
    return showDialog(
      context: contex,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
