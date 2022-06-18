import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_hospital/model/all_pation_model.dart';
import 'package:cloud_hospital/model/disease_by_pationt_model.dart';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as myGet;
import 'package:image_picker/image_picker.dart';

import '../controllers/dashboard_controller.dart';
import '../model/all_disease_model.dart';
import '../model/all_doctor_model.dart';
import '../model/department_doctor_model.dart';
import '../services/sp_helper.dart';
import '../utils/constants.dart';
import '../utils/helper.dart';
import '../utils/progress_dialog_utils.dart';

class DashboardApis {
  DashboardApis._();

  static DashboardApis dashboardApis = DashboardApis._();
  Dio dio;

  DashboardController dashboardController = myGet.Get.find();

  initDio() {
    if (dio == null) {
      dio = Dio();
      return dio;
    } else {
      return dio;
    }
  }

  //------------------------------------- ADMIN DASHBOARD ---------------------------------------//
  List<dynamic> patientList = [];

  getAllPation({int pageNumber = 1}) async {
    try {
      String token = SPHelper.spHelper.getToken();
      initDio();
      ProgressDialogUtils.show();

      Response response = await dio.get(
        baseUrl + allPationtURL + '?page=$pageNumber',
        options: Options(headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token'
        }),
      );
      if (response.statusCode == 200) {
        dashboardController.getAllPationtModelData.value =
            AllPationtModel.fromJson(response.data);

        dashboardController.getAllPationtModelData.value.data.patients
            .forEach((element) {
          patientList.add(element);
        });

        print(
            " AllPationtModel Successful Stored +${response.data.toString()}");
        ProgressDialogUtils.hide();
      } else {
        ProgressDialogUtils.hide();
      }
    } catch (err) {
      ProgressDialogUtils.hide();
      print("AllPationtModel ERROR  $err");
    }
  }

  getAllDoctor() async {
    try {
      String token = SPHelper.spHelper.getToken();
      initDio();

      Response response = await dio.get(
        baseUrl + allDoctorURL,
        options: Options(headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token'
        }),
      );
      if (response.statusCode == 200) {
        dashboardController.getAllDoctorModelData.value =
            AllDoctorsModel.fromJson(response.data);
        print(" AllDoctorsModel Successful Stored ${response.data}");
        ProgressDialogUtils.hide();
      } else {
        ProgressDialogUtils.hide();
      }
    } catch (err) {
      ProgressDialogUtils.hide();
      print("DepartmentDoctorModel  $err");
    }
  }

  getDiseaseByPatient(int patientId) async {
    try {
      String token = SPHelper.spHelper.getToken();
      initDio();

      Response response = await dio.get(
        baseUrl + DiseaseByPatientURL + '$patientId',
        options: Options(headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token'
        }),
      );
      if (response.statusCode == 200) {
        dashboardController.getDiseaseByPatientModelData.value =
            DiseaseByPatientModel.fromJson(response.data);
        print(" DiseaseByPatientModel Successful Stored ${response.data}");
        ProgressDialogUtils.hide();
      } else {
        ProgressDialogUtils.hide();
      }
    } catch (err) {
      ProgressDialogUtils.hide();
      print("DiseaseByPatientModel  $err");
    }
  }

  assignPationtDiseaseToDoctor(String doctor_id, String patiant_id,
      String disease_id, String appointment) async {
    try {
      String token = SPHelper.spHelper.getToken();
      initDio();
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        'doctor_id': doctor_id,
        'patiant_id': patiant_id,
        'appointment': appointment,
        'disease_id': disease_id,

      });
      Response response = await dio.post(
        baseUrl + assignDiseaseByPatientURL,
        data: data,
        options: Options(headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token'
        }),
      );

      if (response.statusCode == 200) {
        ProgressDialogUtils.hide();
        myGet.Get.back();
        Helper.getSheetSucsses(response.data['message']);
        print(" assignPationtDiseaseToDoctor Successful  ${response.data.toString()}");
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError("هناك خطأ");
      }
    } catch (err) {
      ProgressDialogUtils.hide();
      print("assignPationtDiseaseToDoctor Error  $err");
    }
  }

  //------------------------------------- PATIENT DASHBOARD ---------------------------------------//

  addPationtDiseaseWithImage({String name, String description, image}) async {
    try {
      Uint8List uint8list = await image.readAsBytes();
      List<int> list = uint8list.cast();
      String token = SPHelper.spHelper.getToken();
      initDio();
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        'name': name,
        'description': description,
        'file': image != null
            ? MultipartFile.fromBytes(list, filename: 'file.png')
            : null,
      });
      Response response = await dio.post(
        baseUrl + addDiseasesURL,
        data: data,
        options: Options(headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token'
        }),
      );

      if (response.statusCode == 201) {
        // print(" addPationtDisease Successful Stored ${response.data.toString()}");
        await getPationtDisease();
        ProgressDialogUtils.hide();
        myGet.Get.back();
        Helper.getSheetSucsses(response.data['message']);
        print(" addPationtDisease Successful  ${response.data.toString()}");
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError("هناك خطأ في إضافة مرض");
      }
    } catch (err) {
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response.data['message']);
      print("addPationtDisease Error  $err");
    }
  }

  addPationtDiseaseWithoutImage({String name, String description}) async {
    try {
      String token = SPHelper.spHelper.getToken();
      initDio();
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        'name': name,
        'description': description,
      });
      Response response = await dio.post(
        baseUrl + addDiseasesURL,
        data: data,
        options: Options(headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token'
        }),
      );

      if (response.statusCode == 201) {
        // print(" addPationtDisease Successful Stored ${response.data.toString()}");
        await getPationtDisease();
        ProgressDialogUtils.hide();
        myGet.Get.back();
        Helper.getSheetSucsses(response.data['message']);
        print(" addPationtDisease Successful  ${response.data.toString()}");
      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError("هناك خطأ في إضافة مرض");
      }
    } catch (err) {
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response.data['message']);
      print("addPationtDisease Error  $err");
    }
  }

  getPationtDisease() async {
    try {
      String token = SPHelper.spHelper.getToken();
      initDio();
      ProgressDialogUtils.show();
      Response response = await dio.get(
        baseUrl + getDiseasesURL,
        options: Options(headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token'
        }),
      );

      if (response.statusCode == 200) {
        dashboardController.getAllDiseasesModelData.value =
            AllDiseasesModel.fromJson(response.data);
        print(" GetPationtDisease response ${response.data.toString()}");
        ProgressDialogUtils.hide();
        print(" GETPationtDisease Successful Stored");
      } else {
        ProgressDialogUtils.hide();
      }
    } catch (err) {
      ProgressDialogUtils.hide();
      print("addPationtDisease Error  $err");
    }
  }

  addSpecialties(String name) async {
    try {
      String token = SPHelper.spHelper.getToken();
      initDio();
      ProgressDialogUtils.show();
      FormData data = FormData.fromMap({
        'name': name,
      });
      Response response = await dio.post(
        baseUrl + addSpecialitiesURL,
        data: data,
        options: Options(headers: {
          "Accept": "application/json",
          'Authorization': 'Bearer $token'
        }),
      );

      if (response.statusCode == 201) {
        print(" addSpecialties Successful Stored ${response.data}");
        await getSpecialties();
        ProgressDialogUtils.hide();
        myGet.Get.back();
        Helper.getSheetSucsses(response.data['message']);
        //  print(" addSpecialties Successful Stored ${response.data}");

      } else {
        ProgressDialogUtils.hide();
        Helper.getSheetError("هناك خطأ في إضافة تخصص");
      }
    } catch (err) {
      ProgressDialogUtils.hide();
      Helper.getSheetError(err.response.data['message']);
      print("addSpecialties Error  $err");
    }
  }

  getSpecialties() async {
    try {
      initDio();
      Response response = await dio.get(
        baseUrl + departmentURL,
      );
      if (response.statusCode == 200) {
        dashboardController.getDepartmentDoctorModelData.value =
            DepartmentDoctorModel.fromJson(response.data);
        print(" DepartmentDoctorModel ${response.data}");
      } else {}
    } catch (err) {
      print("DepartmentDoctorModel  $err");
    }
  }
}
