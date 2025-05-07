part of 'chat_bloc.dart';

sealed class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class LoadChatsRequested extends ChatEvent{
  const LoadChatsRequested();
}

final class SearchChatsRequested extends ChatEvent{
  final String query;
  const SearchChatsRequested(this.query);
  @override
  // TODO: implement props
  List<Object?> get props => [query];
}

final class SendMessageRequested extends ChatEvent{
  final String chatId;
  final String content;

  const SendMessageRequested(this.chatId, this.content,);

  @override
  // TODO: implement props
  List<Object?> get props => [chatId, content,];
}
