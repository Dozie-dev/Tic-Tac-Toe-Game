import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/colors/color.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfileState();
}

class _ProfileState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Profile'),
        titleTextStyle: GoogleFonts.coiny(
          textStyle: TextStyle(color: Appcolor.primaryColor, fontSize: 40),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(top: 15),
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Image.asset('assets/images/profilepic.png', width: 300),
                  Text(
                    'Username',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.coiny(color: Colors.black, fontSize: 30),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Appcolor.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: SizedBox(
                      width: 150,
                      child: Text(
                        'TicTacToe is Fun With Friends',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.coiny(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),

                  Transform.rotate(
                    angle: 0.2,
                    child: Image.asset('assets/images/tictactoe.png'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),

            Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Email:',
                    style: GoogleFonts.coiny(
                      textStyle: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'promiseamaechi16@gmail.com',
                    style: GoogleFonts.coiny(
                      textStyle: TextStyle(fontSize: 25, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 70),

            SizedBox(
              width: 300,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {},
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    'LOG OUT',
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
    );
  }
}
