part of 'chat_bloc.dart';

sealed class ChatState extends Equatable {
  final List<Chat>? chats;
  final List<Chat>? filteredChats;
  final List<Message>? messages;
  final String? error;

  const ChatState({this.chats, this.filteredChats, this.messages, this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [chats, filteredChats, messages, error];
}

final class ChatInitial extends ChatState {
  const ChatInitial()
    : super(chats: null, filteredChats: null, messages: null, error: null);
}

final class ChatLoading extends ChatState {
  const ChatLoading()
    : super(chats: null, filteredChats: null, messages: null, error: null);
}

final class ChatLoaded extends ChatState {
  const ChatLoaded({
    required List<Chat> chats,
    required List<Chat> filteredChats,
    required List<Message> messages,
    String? error,
  }) : super(
         chats: chats,
         filteredChats: filteredChats,
         messages: messages,
         error: error,
       );
}

final class ChatFailure extends ChatState {
  const ChatFailure({
    required String error,
    List<Chat>? chats,
    List<Chat>? filteredChats,
    List<Message>? messages,
  }) : super(
         error: error,
         chats: chats,
         filteredChats: filteredChats,
         messages: messages,
       );
}
