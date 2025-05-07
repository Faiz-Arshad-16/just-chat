import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../app/theme/style.dart';
import '../../data/models/chats_list_model.dart';


class ChatListGenerate extends StatelessWidget {
  final List<Chat> chats;
  const ChatListGenerate({super.key, required this.chats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return _buildChatList(context, chat);
      },
    );
  }

  Widget _buildChatList(BuildContext context, Chat chat) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/chats', arguments: chat);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: appBarColor,
                  child: Text(
                    chat.name.isNotEmpty ? chat.name[0].toUpperCase() : '?',
                    style: GoogleFonts.comfortaa(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chat.name,
                        style: GoogleFonts.comfortaa(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: textColor,
                        ),
                      ),
                      Text(
                        chat.lastMessage.isEmpty || chat.lastMessage == '' ? 'No message yet' : chat.lastMessage,
                        softWrap: true,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.comfortaa(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: secondaryTextColor,
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  chat.lastMessageTime,
                  style: GoogleFonts.comfortaa(
                    fontSize: 11,
                    color: secondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Container(
            width: double.infinity,
            height: 1,
            color: secondaryTextColor.withOpacity(0.5),
          )
        ],
      ),
    );
  }
}
