import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/colors/color.dart';
import 'package:tictactoe/pages/firebase_auth/auth_service.dart';
import 'package:tictactoe/pages/tools/app_loading.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final user = authService.value.currentUser;
  bool isVerified = false;
  bool isLoading = false;

  Future<void> checkVerification() async {
    setState(() => isLoading = true);

    await FirebaseAuth.instance.currentUser?.reload();
    isVerified = FirebaseAuth.instance.currentUser?.emailVerified ?? false;

    setState(() => isLoading = false);
    if (isVerified) {
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(
      builder: (context, isKeyboardVisible) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text('Verify Your Email'),
            titleTextStyle: GoogleFonts.coiny(
              textStyle: TextStyle(color: Appcolor.primaryColor, fontSize: 30),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_new_rounded),
              ),
            ),
          ),
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(bottom: isKeyboardVisible ? 250 : 0),
            child: Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Image.asset('assets/images/emailpic.png'),
                        ),

                        Text(
                          'Check ${user?.email}',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.coiny(
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        SizedBox(height: 50),

                        isLoading
                            ? const AppLoadingPage()
                            : Text(
                              'We have sent a verification email.\nPlease verify and come back.',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.coiny(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),

                        SizedBox(height: 30),

                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () async {
                              await FirebaseAuth.instance.currentUser
                                  ?.sendEmailVerification();
                            },
                            child: Text(
                              'Resend Code?',
                              style: GoogleFonts.coiny(
                                textStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 100),

                        SizedBox(
                          width: 350,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              backgroundColor: Appcolor.primaryColor,
                            ),
                            onPressed: checkVerification,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Text(
                                'VERIFY',
                                style: GoogleFonts.coiny(
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Text(
                    textAlign: TextAlign.center,
                    'DOZIE TECHNOLOGIES',
                    style: GoogleFonts.coiny(
                      textStyle: TextStyle(
                        color: Appcolor.primaryColor,
                        letterSpacing: 3,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
