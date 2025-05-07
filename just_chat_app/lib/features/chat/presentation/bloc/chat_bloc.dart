import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:just_chat_app/features/chat/data/models/message_list_model.dart';

import '../../data/models/chats_list_model.dart';

part 'chat_event.dart';

part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    on<LoadChatsRequested>((event, emit) {
      emit(ChatLoading());
      try {
        emit(
          ChatLoaded(
            chats: allChats,
            filteredChats: allChats,
            messages: allMessages,
            error: null,
          ),
        );
      } catch (e) {
        emit(
          ChatFailure(
            error: e.toString(),
            messages: state.messages,
            chats: state.chats,
            filteredChats: state.filteredChats,
          ),
        );
      }
    });

    on<SearchChatsRequested>((event, emit) {
      emit(ChatLoading());
      try {
        final chats = state.chats ?? allChats;
        final query = event.query.toLowerCase();
        final filteredChats =
            query.isEmpty
                ? chats
                : chats
                    .where(
                      (chat) =>
                          chat.name.toLowerCase().contains(query) ||
                          chat.lastMessage.toLowerCase().contains(query),
                    )
                    .toList();
        emit(
          ChatLoaded(
            chats: chats,
            filteredChats: filteredChats,
            messages: state.messages ?? allMessages,
            error: null,
          ),
        );
      } catch (e) {
        emit(
          ChatFailure(
            error: e.toString(),
            filteredChats: state.filteredChats,
            chats: state.chats,
            messages: state.messages,
          ),
        );
      }
    });

    on<SendMessageRequested>((event, emit) {
      emit(ChatLoading());
      try {
        if (event.content.trim().isEmpty) {
          throw Exception('Messages cannot be empty');
        }
        final messages = state.messages ?? allMessages;
        final newMessage = Message(
          id: '${messages.length + 1}',
          chatId: event.chatId,
          senderId: 'User',
          content: event.content,
          timestamp: DateTime.now(),
        );
        final updatedMessages = [...messages, newMessage];
        emit(
          ChatLoaded(
            chats: state.chats ?? allChats,
            filteredChats: state.filteredChats ?? allChats,
            messages: updatedMessages,
            error: null,
          ),
        );
      } catch (e) {
        emit(
          ChatFailure(
            error: e.toString(),
            chats: state.chats,
            messages: state.messages,
            filteredChats: state.filteredChats,
          ),
        );
      }
    });
  }
}
