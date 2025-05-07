import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app/theme/style.dart';
import '../../data/models/chats_list_model.dart';
import '../bloc/chat_bloc.dart';

class ChatConversationPage extends StatefulWidget {
  final Chat chat;

  const ChatConversationPage({super.key, required this.chat});

  @override
  State<ChatConversationPage> createState() => _ChatConversationPageState();
}

class _ChatConversationPageState extends State<ChatConversationPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _messageController.dispose();
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
            } else if (state is ChatLoaded &&
                state.messages != null &&
                state.messages!.any(
                  (msg) =>
                      msg.chatId == widget.chat.id &&
                      msg.content == _messageController.text &&
                      msg.timestamp.isAfter(
                        DateTime.now().subtract(Duration(seconds: 1)),
                      ),
                )) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("Message Sent")));
              _messageController.clear();
            }
          },
          builder: (context, state) {
            if (state is ChatLoading) {
              return Center(
                child: CircularProgressIndicator(color: sendMessageColor),
              );
            }
            final chatMessages =
                (state.messages ?? [])
                    .where((messages) => messages.chatId == widget.chat.id)
                    .toList();
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: backgroundColor,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: appBarColor,
                          ),
                          child: Center(
                            child: Text(
                              widget.chat.name.isNotEmpty
                                  ? widget.chat.name[0].toUpperCase()
                                  : '?',
                              style: GoogleFonts.comfortaa(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        widget.chat.name,
                        style: GoogleFonts.comfortaa(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child:
                              chatMessages.isEmpty
                                  ? Center(
                                    child: Text(
                                      'No messages yet',
                                      style: GoogleFonts.comfortaa(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: secondaryTextColor,
                                      ),
                                    ),
                                  )
                                  : ListView.builder(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 20,
                                    ),
                                    itemCount: chatMessages.length,
                                    itemBuilder: (context, index) {
                                      final message = chatMessages[index];
                                      final isUser = message.senderId == 'User';
                                      return Align(
                                        alignment:
                                            isUser
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color:
                                                isUser
                                                    ? sendMessageColor
                                                    : receiveMessageColor,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15),
                                              bottomLeft:
                                                  isUser
                                                      ? Radius.circular(15)
                                                      : Radius.zero,
                                              bottomRight:
                                                  isUser
                                                      ? Radius.zero
                                                      : Radius.circular(15),
                                            ),
                                          ),
                                          child: Text(
                                            message.content,
                                            style: GoogleFonts.comfortaa(
                                              fontSize: 16,
                                              color: textColor,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 20,
                          ),
                          child: Container(
                            constraints: BoxConstraints(maxHeight: 120),
                            decoration: BoxDecoration(
                              color: receiveMessageColor,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: sendMessageColor,
                                width: 2,
                              ),
                            ),
                            child: TextField(
                              controller: _messageController,
                              style: GoogleFonts.comfortaa(
                                fontSize: 14,
                                color: textColor,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Type a message...',
                                hintStyle: GoogleFonts.comfortaa(
                                  fontSize: 14,
                                  color: textColor,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15,
                                  horizontal: 20,
                                ),
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.send,
                                    color: sendMessageColor,
                                  ),
                                  onPressed: () {
                                    if (_messageController.text
                                        .trim()
                                        .isNotEmpty) {
                                      context.read<ChatBloc>().add(
                                        SendMessageRequested(
                                          widget.chat.id,
                                          _messageController.text.trim(),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              cursorColor: textColor,
                              minLines: 1,
                              maxLines: null,
                              onTapOutside: (_) {
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
