import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:just_chat_app/features/app/theme/style.dart';
import 'package:just_chat_app/features/profile/presentation/widgets/profile_text_field.dart';
import 'package:path_provider/path_provider.dart';

import '../bloc/profile_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _pic = ImagePicker();

  Future<void> profilePic() async {
    final imagePicked = await _pic.pickImage(source: ImageSource.gallery);
    if (imagePicked != null) {
      final tempDir = await getTemporaryDirectory();
      final newImage = await File(
        imagePicked.path,
      ).copy('${tempDir.path}/profile_pic.jpg');
      context.read<ProfileBloc>().add(UpdateProfilePicRequested(newImage.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        } else if (state is ProfileUpdated && state.passwordChanged == true) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password changed successfully')),
          );
          context.read<ProfileBloc>().add(ClearPasswordChanged());
        } else if (state is ProfileLoggedOut) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/login',
            (route) => false,
          );
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Logged out successfully')));
        }
      },
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Scaffold(
            backgroundColor: appBarColor,
            body: Center(
              child: CircularProgressIndicator(color: sendMessageColor),
            ),
          );
        }
        final username = state.username ?? 'User';
        final email = state.email ?? 'example@domain.com';
        return Scaffold(
          backgroundColor: appBarColor,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 40,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: backgroundColor,
                      ),
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: textColor),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: 15),
                    Text(
                      "Profile Settings",
                      style: GoogleFonts.comfortaa(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            profilePic();
                          },
                          child: CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.white,
                            child:
                                state.profilePicUrl == null
                                    ? Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: appBarColor,
                                          width: 6,
                                        ),
                                        borderRadius: BorderRadius.circular(70),
                                      ),
                                      child: Center(
                                        child: Text(
                                          username.isNotEmpty
                                              ? username[0].toUpperCase()
                                              : '+',
                                          style: GoogleFonts.comfortaa(
                                            fontSize: 42,
                                            fontWeight: FontWeight.bold,
                                            color: appBarColor,
                                          ),
                                        ),
                                      ),
                                    )
                                    : Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Image.file(
                                        File(state.profilePicUrl!),
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: appBarColor,
                                                width: 6,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(70),
                                            ),
                                            child: Center(
                                              child: Text(
                                                username.isNotEmpty
                                                    ? username[0].toUpperCase()
                                                    : 'U',
                                                style: GoogleFonts.comfortaa(
                                                  fontSize: 42,
                                                  fontWeight: FontWeight.bold,
                                                  color: appBarColor,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "Edit profile picture",
                          style: GoogleFonts.comfortaa(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: textColor,
                          ),
                        ),
                        SizedBox(height: 40),
                        ProfileTextField(
                          hintText: "Username",
                          initialValue: username,
                          isEditable: true,
                          onChanged: (value) {
                            context.read<ProfileBloc>().add(
                              UpdateUsernameRequested(value),
                            );
                          },
                        ),
                        SizedBox(height: 30),
                        ProfileTextField(
                          hintText: "Email",
                          initialValue: email,
                          isEditable: false,
                        ),
                        SizedBox(height: 30),
                        ProfileTextField(
                          hintText: "Change Password",
                          isEditable: true,
                          isPassword: true,
                          onTap: () {
                            _showPasswordChangeDialog(context);
                          },
                        ),
                        SizedBox(height: 40),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.read<ProfileBloc>().add(
                                LogoutRequested(),
                              );
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
                              "Logout",
                              style: GoogleFonts.comfortaa(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPasswordChangeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        String? currentPassword;
        String? newPassword;
        String? confirmPassword;
        final formKey = GlobalKey<FormState>();

        return AlertDialog(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Change Password',
            style: GoogleFonts.comfortaa(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfileTextField(
                    hintText: 'Current Password',
                    isPassword: true,
                    onChanged: (value) => currentPassword = value,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter current password';
                      }
                      return null; // Add real validation with Firebase later
                    },
                  ),
                  const SizedBox(height: 15),
                  ProfileTextField(
                    hintText: 'New Password',
                    isPassword: true,
                    onChanged: (value) => newPassword = value,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a new password';
                      }
                      const passwordPattern =
                          r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
                      final regex = RegExp(passwordPattern);
                      if (!regex.hasMatch(value.trim())) {
                        return 'Password must be 8+ characters with letters and numbers';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  ProfileTextField(
                    hintText: 'Confirm New Password',
                    isPassword: true,
                    onChanged: (value) => confirmPassword = value,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value.trim() != newPassword?.trim()) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.comfortaa(
                  color: secondaryTextColor,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<ProfileBloc>().add(
                    ChangePasswordRequested(
                      currentPassword!,
                      newPassword!,
                      confirmPassword!,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: sendMessageColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Change',
                style: GoogleFonts.comfortaa(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
