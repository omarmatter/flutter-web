import 'package:cloud_hospital/apis/auth_apis.dart';
import 'package:cloud_hospital/apis/dashboard_apis.dart';
import 'package:cloud_hospital/pages/authentication/login_screen.dart';
import 'package:cloud_hospital/pages/authentication/register_screen.dart';
import 'package:cloud_hospital/widgets/custom_image.dart';
import 'package:flutter/material.dart';
import '../../constants/style.dart';


class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  GlobalKey<FormState> formStateRegister = GlobalKey<FormState>();
  GlobalKey<FormState> formStateLogin = GlobalKey<FormState>();

  Option selectedOption = Option.LogIn;
@override
  void initState() {
      DashboardApis.dashboardApis.getSpecialties();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    print(size.height);
    print(size.width);

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [

            Row(
              children: [
                Container(
                  height: double.infinity,
                  width: size.width / 2,
                  color: primaryColor,
                ),
                Container(
                    height: double.infinity,
                    width: size.width / 2,
                    color: Colors.white
                ),
              ],
            ),

            // Align(
            //   alignment: Alignment.topRight,
            //   child: Padding(
            //     padding: EdgeInsets.all(32),
            //     child: Text(
            //       "مرحبا",
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 24,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            // ),

            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CustomSvgImage(imageName: 'login_image',width: 200,height: 300,),
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: CustomSvgImage(imageName: 'signup_image',width: 100,height: 250,),
              ),
            ),



            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [

                    Icon(
                      Icons.copyright,
                      color: Colors.grey,
                      size: 24,
                    ),

                    SizedBox(
                      width: 8,
                    ),

                    Text(
                      "Copyright 2022",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),

                  ],
                ),
              ),
            ),

            AnimatedSwitcher(
              duration: Duration(milliseconds: 500),

              //Animation 1
              //transitionBuilder: (widget, animation) => RotationTransition(
              //  turns: animation,
              //  child: widget,
              //),
              //switchOutCurve: Curves.easeInOutCubic,
              //switchInCurve: Curves.fastLinearToSlowEaseIn,

              //Animation 2
              transitionBuilder: (widget, animation) => ScaleTransition(
                  child: widget,
                  scale: animation
              ),

              child: selectedOption == Option.LogIn
                  ? LoginScreen(
                onSignUpSelected: () {
                  setState(() {
                    selectedOption = Option.SignUp;
                  });
                },
                formStateLogin: formStateLogin,
              )
                  : RegisterScreen(
                onLogInSelected: () {
                  setState(() {
                    selectedOption = Option.LogIn;
                  });
                },
                formStateRegister: formStateRegister,
              ),
            ),

          ],
        ),
      ),
    );
  }
}