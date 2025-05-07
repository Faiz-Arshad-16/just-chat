import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_chat_app/features/app/theme/style.dart';
import 'package:just_chat_app/features/user/presentation/widgets/reusable_text_field.dart';

import '../bloc/user_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if(state is UserLoaded){
          Navigator.pushReplacementNamed(context, '/home');
        } else if(state is UserFailure){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 80,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Just Chat",
                      style: GoogleFonts.comfortaa(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                    SizedBox(height: 80),
                    Text(
                      "Please login to continue",
                      style: GoogleFonts.comfortaa(
                        fontSize: 18,
                        color: secondaryTextColor,
                      ),
                    ),
                    SizedBox(height: 40),
                    ReusableTextField(
                      isEmail: true,
                      onChanged: (value) => setState(() {
                        _email = value;
                      })
                    ),
                    SizedBox(height: 30),
                    ReusableTextField(
                      isEmail: false,
                      onChanged: (value) => setState(() {
                        _password = value;
                      })
                    ),
                    SizedBox(height: 40),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.read<UserBloc>().add(LoginRequested(_email, _password));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: sendMessageColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Login",
                          style: GoogleFonts.comfortaa(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 130),
                    RichText(
                      text: TextSpan(
                        text: "Don't have an account?",
                        style: GoogleFonts.comfortaa(
                          fontSize: 18,
                          color: secondaryTextColor,
                        ),
                        children: [
                          TextSpan(
                            text: " Sign up",
                            style: GoogleFonts.comfortaa(
                              fontSize: 18,
                              color: sendMessageColor,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(context, '/signup');
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
