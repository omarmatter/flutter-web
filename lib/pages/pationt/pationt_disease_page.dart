import 'package:cloud_hospital/constants/style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../apis/dashboard_apis.dart';
import '../../constants/controllers.dart';
import '../../controllers/dashboard_controller.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/custom_text_form_field.dart';
import 'widgets/pationt_disease_table.dart';

class PationtDiseasePage extends StatelessWidget {
  DashboardController dashboardController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                            title: Text('إضافة مرض'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CustomTextFormField(
                                  suffixIcon: Icons.mail_outline,
                                  hint: 'اسم المرض',
                                  onSaved: dashboardController.setDiseaseName,
                                  validator:
                                      dashboardController.validationDiseaseName,
                                  // controller:spController ,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                CustomTextFormField(
                                  suffixIcon: Icons.mail_outline,
                                  hint: 'تفاصيل عن المرض',
                                  onSaved:
                                      dashboardController.setDiseaseDetails,
                                  validator: dashboardController
                                      .validationDiseaseDetails,
                                  // controller:spController ,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                CustomText(text: 'إرفاق وثيقة', size: 15),
                                const SizedBox(
                                  height: 10,
                                ),

                                GetBuilder<DashboardController>(
                                  init: DashboardController(),
                                  builder: (controller) {
                                    return GestureDetector(
                                      onTap: () async {
                                        PickedFile picture = await ImagePicker().getImage(
                                                source: ImageSource.gallery);
                                        controller.setPreviewImage(picture);
                                      },
                                      child: controller.image == null
                                          ? Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: borderColor),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              width: 300,
                                              height: 100,
                                              child: Center(
                                                  child: Icon(Icons.image)),
                                            )
                                          : Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: borderColor),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Image.network(
                                                  controller.image.path),
                                              width: 300,
                                              height: 100,
                                            ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),

                              ],
                            ),
                            actions: [
                              GetBuilder<DashboardController>(
                                init: DashboardController(),
                                builder: (controller){
                                  return TextButton(
                                    onPressed: () {
                                      // print(PickedFile(controller.image.path));
                                      // print(controller.image.path);
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                       if(controller.image!=null){
                                         DashboardApis.dashboardApis
                                             .addPationtDiseaseWithImage(
                                             name: dashboardController.diseaseName,
                                             description:
                                             dashboardController.diseaseDetails,
                                             image: controller.image
                                         );
                                       }else{
                                         DashboardApis.dashboardApis
                                             .addPationtDiseaseWithoutImage(
                                             name: dashboardController.diseaseName,
                                             description:
                                             dashboardController.diseaseDetails,
                                         );
                                       }
                                      }
                                    },
                                    child: const CustomText(
                                      text: "إضافة",
                                      color: primaryColor,
                                      size: 16,
                                    ),
                                  );
                                },
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
              child: ListView(
            children: [PationtDiseaseTable()],
          )),
        ],
      ),
    );
  }
}
