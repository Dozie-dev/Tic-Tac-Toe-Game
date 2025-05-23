import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/colors/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/pages/firebase_auth/auth_service.dart';
import 'package:tictactoe/pages/first_screens/landing_page.dart';
import 'package:tictactoe/pages/user_auth/forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.primaryColor,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 80),
                    Padding(
                      padding: const EdgeInsets.only(right: 200),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOGIN',
                            style: GoogleFonts.coiny(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 60,
                              ),
                            ),
                          ),
                          Text(
                            'WELCOME BACK',
                            style: GoogleFonts.coiny(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: MediaQuery.of(context).size.height - 110,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 50),
                            Center(
                              child: Text(
                                'Tic-Tac-Toe Game',
                                style: GoogleFonts.coiny(
                                  color: Appcolor.primaryColor,
                                  fontSize: 30,
                                  letterSpacing: 3,
                                ),
                              ),
                            ),
                            SizedBox(height: 30),

                            // First Text Field - Enter email
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Enter email',
                                style: GoogleFonts.coiny(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                ),
                                style: GoogleFonts.coiny(
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                                validator:
                                    (value) =>
                                        value == null || value.isEmpty
                                            ? 'Enter your email'
                                            : null,
                              ),
                            ),
                            SizedBox(height: 20),

                            // Second Text Field - Password
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                'Enter Password',
                                style: GoogleFonts.coiny(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black54,
                                    blurRadius: 20,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: TextFormField(
                                controller: passwordController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                  ),
                                ),
                                style: GoogleFonts.coiny(
                                  color: Colors.black,
                                  fontSize: 25,
                                ),
                                validator:
                                    (value) =>
                                        value == null || value.isEmpty
                                            ? 'Enter your password'
                                            : null,
                              ),
                            ),

                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                errorMessage,
                                style: GoogleFonts.coiny(
                                  textStyle: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ForgotPassword(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Forgot Password?',
                                  style: GoogleFonts.coiny(
                                    textStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 60),

                            // Login Button
                            Center(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Appcolor.primaryColor,
                                ),
                                onPressed: () async {
                                  try {
                                    await authService.value.signIn(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => FirstPage(),
                                      ),
                                    );
                                    setState(() => errorMessage = '');
                                  } on FirebaseAuthException catch (_) {
                                    setState(() {
                                      errorMessage =
                                          'Enter Valid Email and Password';
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 15,
                                    bottom: 22,
                                    left: 15,
                                    right: 15,
                                  ),
                                  child: Text(
                                    'LOGIN',
                                    style: GoogleFonts.coiny(
                                      textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
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
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
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
  }
}
