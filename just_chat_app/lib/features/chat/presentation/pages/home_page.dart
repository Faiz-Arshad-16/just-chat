import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/theme/style.dart';
import '../../../profile/presentation/bloc/profile_bloc.dart';
import '../../data/models/chats_list_model.dart';
import '../bloc/chat_bloc.dart';
import '../widgets/chat_list_generate.dart';
import '../widgets/chat_search_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();

  List<Chat> get filteredChats {
    if (_searchController.text.isEmpty) {
      return allChats;
    } else {
      return allChats.where((chat) {
        return chat.name.toLowerCase().contains(
          _searchController.text.toLowerCase(),
        );
      }).toList();
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appBarColor,
        body: BlocConsumer<ChatBloc, ChatState>(
          listener: (context, state) {
            if (state is ChatFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error!)));
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "Connect ",
                                style: GoogleFonts.comfortaa(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w900,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                "With",
                                style: GoogleFonts.comfortaa(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Your Friends!",
                            style: GoogleFonts.comfortaa(
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, profileState) {
                          final initial =
                              profileState.username != null &&
                                      profileState.username!.isNotEmpty
                                  ? profileState.username![0].toUpperCase()
                                  : 'U';
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/profile');
                            },
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child:
                                  profileState.profilePicUrl == null
                                      ? Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: appBarColor,
                                            width: 4,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            initial,
                                            style: GoogleFonts.comfortaa(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: appBarColor,
                                            ),
                                          ),
                                        ),
                                      )
                                      : Container(
                                        width: 45,
                                        height: 45,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: appBarColor,
                                            width: 4,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            25,
                                          ),
                                        ),
                                        child: Image.file(
                                          File(profileState.profilePicUrl!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                ChatSearchBar(
                  controller: _searchController,
                  onChanged: (value) {
                    context.read<ChatBloc>().add(SearchChatsRequested(value));
                  },
                ),
                SizedBox(height: 30),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(top: 15),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: _buildChatContent(state),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildChatContent(ChatState state) {
    if (state is ChatLoading) {
      return Center(child: CircularProgressIndicator(color: sendMessageColor));
    }
    if (state is ChatInitial) {
      return Center(
        child: Text(
          "Initializing chats...",
          style: GoogleFonts.comfortaa(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: secondaryTextColor,
          ),
        ),
      );
    }
    final chats = state.filteredChats ?? [];
    return chats.isNotEmpty
        ? ChatListGenerate(chats: chats)
        : Center(
          child: Text(
            "Start a chat",
            style: GoogleFonts.comfortaa(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: secondaryTextColor,
            ),
          ),
        );
  }
}
