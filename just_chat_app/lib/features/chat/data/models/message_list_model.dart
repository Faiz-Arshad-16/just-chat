class Message {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final DateTime timestamp;

  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.timestamp,
  });
}

final List<Message> allMessages = [
  Message(
    id: '1',
    chatId: '1',
    senderId: 'Micheal John',
    content: 'I’ll check it, wait for a moment.',
    timestamp: DateTime.now().subtract(Duration(minutes: 2)),
  ),
  Message(
    id: '2',
    chatId: '1',
    senderId: 'User',
    content: 'Cool, let me know!',
    timestamp: DateTime.now().subtract(Duration(minutes: 1)),
  ),
  Message(
    id: '1',
    chatId: '2',
    senderId: 'Alice Smith',
    content: 'Hey, how are you?',
    timestamp: DateTime.now().subtract(Duration(minutes: 27)),
  ),
  Message(
    id: '2',
    chatId: '2',
    senderId: 'User',
    content:
        'Doing great, you? And what happened to that'
        'project that you were working on?'
        'Actually I am free now and if you'
        'need any help I can help you out.',
    timestamp: DateTime.now().subtract(Duration(minutes: 6)),
  ),
  Message(
    id: '1',
    chatId: '3',
    senderId: 'Bob Johnson',
    content: 'Let’s meet tomorrow.',
    timestamp: DateTime.now().subtract(Duration(minutes: 32)),
  ),
  Message(
    id: '2',
    chatId: '3',
    senderId: 'User',
    content: 'Sounds good! Where?',
    timestamp: DateTime.now().subtract(Duration(minutes: 20)),
  ),
  Message(
    id: '1',
    chatId: '4',
    senderId: 'Ali Sher',
    content: 'I am pashemaan',
    timestamp: DateTime.now().subtract(Duration(minutes: 12)),
  ),
  Message(
    id: '2',
    chatId: '4',
    senderId: 'User',
    content: 'Koi baat nahi!',
    timestamp: DateTime.now().subtract(Duration(minutes: 3)),
  ),
  Message(
    id: '1',
    chatId: '5',
    senderId: 'Aziz Bhai',
    content: 'Thanks for the help!',
    timestamp: DateTime.now().subtract(Duration(minutes: 22)),
  ),
  Message(
    id: '2',
    chatId: '5',
    senderId: 'User',
    content: 'Anytime!',
    timestamp: DateTime.now().subtract(Duration(minutes: 10)),
  ),
];
