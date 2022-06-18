import 'package:cloud_hospital/constants/style.dart';
import 'package:cloud_hospital/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apis/auth_apis.dart';
import '../../controllers/auth_controller.dart';
import '../../widgets/action_button.dart';
import '../../widgets/custom_image.dart';
import '../../widgets/custom_text.dart';

class LoginScreen extends StatefulWidget {
  final GlobalKey<FormState> formStateLogin;
  final Function onSignUpSelected;

  LoginScreen({@required this.onSignUpSelected, @required this.formStateLogin});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (controller) {
        return Form(
          key: widget.formStateLogin,
          child: Padding(
            padding: EdgeInsets.all(size.height > 770
                ? 64
                : size.height > 670
                    ? 32
                    : 16),
            child: Center(
              child: Card(
                elevation: 4,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: size.height *
                      (size.height > 770
                          ? 0.7
                          : size.height > 670
                              ? 0.8
                              : 0.9),
                  width: 500,
                  color: Colors.white,
                  child: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "تسجيل الدخول",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const SizedBox(
                              width: 30,
                              child: Divider(
                                color: primaryColor,
                                thickness: 2,
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            controller.accountType == 'patient'
                                ? CustomTextFormField(
                                    suffixIcon: Icons.mail_outline,
                                    hint: 'رقم الهوية',
                                    onSaved: authController.setIdNumber,
                                    validator: authController.validationIdNumber,
                                  )
                                : CustomTextFormField(
                                    suffixIcon: Icons.mail_outline,
                                    hint: 'البريد الإلكتروني',
                                    onSaved: authController.setEmail,
                                    validator: authController.validationEmail,
                                  ),
                            const SizedBox(
                              height: 32,
                            ),
                            CustomTextFormField(
                              suffixIcon: Icons.lock_outline,
                              hint: 'كلمة السر',
                              onSaved: authController.setPassword,
                              validator: authController.validationPassword,
                            ),
                            const SizedBox(
                              height: 64,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.setAccountType('Doctor');
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      height: 91,
                                      width: 108,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22),
                                        border: Border.all(
                                            width: 3,
                                            color: controller.accountType ==
                                                    'Doctor'
                                                ? primaryColor
                                                : Colors.grey),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomSvgImage(
                                            imageName: 'doctor',
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          CustomText(
                                            text: 'طبيب',
                                            size: 13,
                                            color: controller.accountType ==
                                                    'Doctor'
                                                ? primaryColor
                                                : Colors.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.setAccountType('patient');
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      height: 91,
                                      width: 108,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22),
                                        border: Border.all(
                                          width: 3,
                                          color: controller.accountType ==
                                                  'patient'
                                              ? primaryColor
                                              : Colors.grey,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomSvgImage(
                                            imageName: 'Patient',
                                            color: controller.accountType ==
                                                    'patient'
                                                ? null
                                                : Colors.grey,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          CustomText(
                                            text: 'مريض',
                                            size: 13,
                                            color: controller.accountType ==
                                                    'patient'
                                                ? primaryColor
                                                : Colors.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.setAccountType('admin');
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 4),
                                      height: 91,
                                      width: 108,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22),
                                        border: Border.all(
                                          width: 3,
                                          color:
                                              controller.accountType == 'admin'
                                                  ? primaryColor
                                                  : Colors.grey,
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          CustomSvgImage(
                                            imageName: 'admin',
                                            color: controller.accountType ==
                                                    'admin'
                                                ? null
                                                : Colors.grey,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          CustomText(
                                            text: 'ادمن',
                                            size: 13,
                                            color: controller.accountType ==
                                                    'admin'
                                                ? primaryColor
                                                : Colors.grey,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            actionButton("تسجيل الدخول", () {
                              if (widget.formStateLogin.currentState
                                  .validate()) {
                                widget.formStateLogin.currentState.save();
                                if (controller.accountType == 'Doctor') {
                                  AuthApis.authApis.loginDoctor(
                                      type: 'doctor',
                                      email: authController.email,
                                      password: authController.password);
                                }
                                else if (controller.accountType == 'patient') {
                                  AuthApis.authApis.loginPatient(
                                      type: 'patient',
                                      idNumber: authController.idNumber,
                                      password: authController.password);
                                }
                                else if (controller.accountType == 'admin') {
                                  AuthApis.authApis.loginAdmin(
                                      type: 'admin',
                                      email: authController.email,
                                      password: authController.password);
                                }
                              }
                            }),
                            const SizedBox(
                              height: 32,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "لا يوجد لديك حساب?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.onSignUpSelected();
                                  },
                                  child: Row(
                                    children: const [
                                      Text(
                                        "سجل الأن",
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Icon(
                                        Icons.arrow_forward,
                                        color: primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
