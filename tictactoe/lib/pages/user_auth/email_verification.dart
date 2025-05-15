import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tictactoe/colors/color.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
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
                'Please Enter the 4 digit code sent to',
                textAlign: TextAlign.center,
                style: GoogleFonts.coiny(textStyle: TextStyle(fontSize: 20)),
              ),
              Text(
                'promiseamaechi16@gmail.com',
                textAlign: TextAlign.center,
                style: GoogleFonts.coiny(
                  textStyle: TextStyle(fontSize: 20, color: Colors.blueAccent),
                ),
              ),
              SizedBox(height: 50),

              PinCodeTextField(
                appContext: context,
                length: 4,
                onChanged: (value) {},
                onCompleted: (value) {},
                keyboardType: TextInputType.number,

                pinTheme: PinTheme(
                  fieldOuterPadding: EdgeInsets.all(10),
                  shape: PinCodeFieldShape.underline,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 60,
                  activeFillColor: Colors.white,
                  inactiveFillColor: Colors.grey.shade200,
                  selectedFillColor: Colors.white,
                  inactiveColor: Colors.grey,
                  activeColor: Colors.blue,
                  selectedColor: Colors.blue,
                ),
                enableActiveFill: true,
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
                  onPressed: () {},
                  child: Text(
                    'Resend Code?',
                    style: GoogleFonts.coiny(
                      textStyle: TextStyle(color: Colors.red, fontSize: 15),
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
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      'VERIFY',
                      style: GoogleFonts.coiny(
                        textStyle: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
