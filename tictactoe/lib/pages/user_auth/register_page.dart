import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/colors/color.dart';
import 'package:tictactoe/pages/firebase_auth/auth_service.dart';
import 'package:tictactoe/pages/user_auth/email_verification.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String errorMessage = '';

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.primaryColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 20,
              bottom: 20,
            ),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'REGISTER USER',
                      style: GoogleFonts.coiny(
                        textStyle: TextStyle(
                          color: Appcolor.primaryColor,
                          letterSpacing: 1,
                          fontSize: 40,
                        ),
                      ),
                    ),
                    Text(
                      'Tic-Tac-Toe Game Auth',
                      style: GoogleFonts.coiny(
                        textStyle: TextStyle(
                          color: Appcolor.primaryColor,
                          letterSpacing: 1,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      child: Column(
                        children: [
                          //-- Username Field
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Username',
                                style: GoogleFonts.coiny(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                              controller: usernameController,
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
                                          ? 'Enter your username'
                                          : null,
                            ),
                          ),

                          //-- Email Field
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Email',
                                style: GoogleFonts.coiny(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
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

                          //-- Password Field
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Password',
                                style: GoogleFonts.coiny(
                                  textStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                          Text(
                            errorMessage,
                            style: GoogleFonts.coiny(
                              textStyle: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          SizedBox(height: 50),

                          SizedBox(
                            width: 300,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                backgroundColor: Appcolor.primaryColor,
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    await authService.value.createAccount(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                    await authService.value.updateUsername(
                                      username: usernameController.text,
                                    );
                                    await FirebaseAuth.instance.currentUser
                                        ?.sendEmailVerification();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => EmailVerification(),
                                      ),
                                    );
                                  } on FirebaseAuthException catch (e) {
                                    setState(() {
                                      errorMessage =
                                          e.message ?? 'There is an error';
                                    });
                                  }
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Text(
                                  'SIGN UP',
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
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
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
    );
  }
}
