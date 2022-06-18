import 'package:cloud_hospital/apis/dashboard_apis.dart';
import 'package:cloud_hospital/widgets/cached_network_image.dart';
import 'package:cloud_hospital/widgets/custom_button.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/style.dart';
import '../../../controllers/app_controller.dart';
import '../../../controllers/dashboard_controller.dart';
import '../../../model/all_doctor_model.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_text_form_field.dart';
import '../../../widgets/dialog_show.dart';

class ClientDisease extends StatefulWidget {
  final String name;
  final String patientId;

  ClientDisease({Key key, this.name,this.patientId}) : super(key: key);

  @override
  State<ClientDisease> createState() => _ClientDiseaseState();
}

class _ClientDiseaseState extends State<ClientDisease> {
  DashboardController dashController = Get.find();
  AppController appController = Get.find();
  Doctors doctorValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            CustomText(
                text: 'اسم المريض  ' + widget.name,
                weight: FontWeight.bold,
                color: primaryColor),
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: active.withOpacity(.4), width: .5),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 6),
                      color: lightGrey.withOpacity(.1),
                      blurRadius: 12),
                ],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 30),
              child:
              Obx(
                      () =>
                  dashController.getDiseaseByPatientModelData.value
                      .data ==
                      null
                      ? Center(child: CircularProgressIndicator())
                      : dashController.getDiseaseByPatientModelData
                      .value.data.isEmpty
                      ? Center(
                    child: CustomText(
                      text: 'لا توجد أمراض مسجلة لهذا المريض',
                    ),
                  )
                      : DataTable2(
                      columnSpacing: 25,
                      horizontalMargin: 12,
                      minWidth: 600,
                      columns: const [
                        DataColumn2(
                          label: Text("اسم المرض"),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Text('تفاصيل عن المرض'),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Text('مرفق'),
                          size: ColumnSize.L,
                        ),
                        DataColumn2(
                          label: Text(''),
                          size: ColumnSize.S,
                        ),
                      ],
                      rows: List<DataRow>.generate(
                          dashController
                              .getDiseaseByPatientModelData
                              .value
                              .data
                              .length, (index) {
                        var patientDisease = dashController
                            .getDiseaseByPatientModelData
                            .value
                            .data[index];
                        return DataRow(cells: [
                          DataCell(CustomText(
                              text: patientDisease.name)),
                          DataCell(CustomText(
                              text:
                              patientDisease.description)),
                          DataCell(CachedNetworkImageShare(
                              'urlImage', 50, 50, 0)),
                          DataCell(patientDisease.bookedUp == 0
                              ? InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible:
                                  false,
                                  builder:
                                      (_) =>
                                      StatefulBuilder(
                                        builder: (context,
                                            setState) =>
                                            AlertDialog(
                                              shape: const RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.all(
                                                      Radius.circular(5.0))),
                                              content:
                                              Builder(
                                                builder:
                                                    (context) {
                                                  return SizedBox(
                                                    height:
                                                    268,
                                                    width:
                                                    300,
                                                    child:
                                                    Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .spaceBetween,
                                                          children: [
                                                            const SizedBox(),
                                                            const CustomText(
                                                                text: 'تعيين المرض إلى طبيب',
                                                                size: 18,
                                                                color: primaryColor),
                                                            IconButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                icon: Icon(Icons
                                                                    .close_outlined)),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        Container(
                                                          alignment: Alignment
                                                              .center,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                              horizontal: 15),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                              horizontal: 15),
                                                          height: 54,
                                                          width: double
                                                              .infinity,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .circular(35),
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          child: DropdownButton<
                                                              Doctors>(
                                                            isExpanded: true,
                                                            hint: Text(
                                                                'Select Doctor'),
                                                            iconSize: 30,
                                                            underline: SizedBox(),
                                                            items: dashController
                                                                .getAllDoctorModelData
                                                                .value.data
                                                                .doctors.map(
                                                                  (value) {
                                                                return DropdownMenuItem<
                                                                    Doctors>(
                                                                  value: value,
                                                                  child: Row(
                                                                    children: [
                                                                      Container(
                                                                        padding: EdgeInsets
                                                                            .all(
                                                                            5),
                                                                        child: Row(
                                                                          children: [
                                                                            Text(
                                                                                value
                                                                                    .name),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ).toList(),
                                                            value: doctorValue,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                doctorValue =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 15,
                                                        ),
                                                        CustomTextFormField(
                                                          controller: appController
                                                              .timeController,
                                                          hint: 'الموعد',
                                                          onTap: () {
                                                            appController
                                                                .selectTime(
                                                                context);
                                                          },
                                                          textAlign: TextAlign
                                                              .center,
                                                        ),
                                                        const SizedBox(
                                                          height: 30,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            CustomButton(
                                                              onTap: () {
                                                                DashboardApis
                                                                    .dashboardApis
                                                                    .assignPationtDiseaseToDoctor(
                                                                    doctorValue.id.toString(),
                                                                    widget.patientId,
                                                                    dashController
                                                                        .getDiseaseByPatientModelData
                                                                        .value
                                                                        .data[index].id.toString(),
                                                                    appController.timeController.text);
                                                              },
                                                              title: 'تعيين',
                                                              btnColor: primaryColor,
                                                              width: 200,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                      ));
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                  color: light,
                                  borderRadius:
                                  BorderRadius
                                      .circular(20),
                                  border: Border.all(
                                      color: active,
                                      width: .5),
                                ),
                                padding:
                                EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6),
                                child: CustomText(
                                  text: "تعيين إلى دكتور",
                                  color: active
                                      .withOpacity(.7),
                                  weight: FontWeight.bold,
                                )),
                          )
                              : const SizedBox()),
                        ]);
                      }))),
            )
          ],
        ),
      ),
    );
  }
}
