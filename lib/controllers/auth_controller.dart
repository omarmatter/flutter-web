




import 'dart:io';

import 'package:cloud_hospital/model/login_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../model/department_doctor_model.dart';
import '../model/register_model.dart';

class AuthController extends GetxController {
  Rx<RegisterModel> getRegisterModelData = RegisterModel().obs;
  Rx<LoginModel> getLoginModelData = LoginModel().obs;

  //============UserType=============
  String accountType = 'patient';

  setAccountType(String accountType) {
    this.accountType = accountType;
    update();
  }
  //============Login=============
  String email,idNumber, password;



  setEmail(String value) => this.email = value;
  setIdNumber(String value) => this.idNumber = value;
  setPassword(String value) => this.password = value;

  validationEmail(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return "الرجاء ادخال البريد الإلكتروني";
    }
  }
  validationIdNumber(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return "الرجاء ادخال رقم الهوية";
    }
  }

  validationPassword(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return "الرجاء ادخال كلمة المرور";
    }
  }



  //============Register=============
  String  emailR, nameR, idNumberR , passwordR, confirmPassword;



  setEmailR(String value) {
    this.emailR = value;
  }

  setNameR(String value) {
    this.nameR = value;
  }

  setIdNumberR(String value) {
    this.idNumberR = value;
  }

  setPasswordR(String value) {
    this.passwordR = value;
  }

  setConfirmPasswordR(String value) {
    this.confirmPassword = value;
  }



  validationEmailR(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return "الرجاء ادخال بريد الكتروني";
    }
    // if (!GetUtils.isEmail(value)) {
    //   return 'البريد المدخل غير صحيح';
    // }
  }

  validationNameR(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return "الرجاء ادخال الاسم";
    }
  }
  validationIdNumR(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return "الرجاء ادخال رقم الهوية";
    }
  }

  validationPasswordR(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return "الرجاء ادخال كلمة المرور";
    }
    if (value.length < 8) {
      return 'يجب ان يكون اكثر من 8 خانات';
    }
  }

  validationConfirmPasswordR(String value) {
    if (GetUtils.isNull(value) || value.isEmpty) {
      return "الرجاء ادخال تأكيد كلمة المرور";
    }
    if (value != this.passwordR) {
      return "كلمة المرور غير متطابقة";
    }
  }

}
