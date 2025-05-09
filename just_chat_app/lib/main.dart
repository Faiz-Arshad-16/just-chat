// import 'package:flutter/material.dart';
// import 'package:just_chat_app/core/di/injection.dart';
// import 'package:just_chat_app/features/chat/data/models/chats_list_model.dart';
// import 'package:just_chat_app/features/chat/presentation/bloc/chat_bloc.dart';
// import 'package:just_chat_app/features/chat/presentation/pages/chat_conversation_page.dart';
// import 'package:just_chat_app/features/chat/presentation/pages/home_page.dart';
// import 'package:just_chat_app/features/profile/presentation/bloc/profile_bloc.dart';
// import 'package:just_chat_app/features/profile/presentation/pages/profile_page.dart';
// import 'package:just_chat_app/features/user/domain/use_cases/is_authenticated.dart';
// import 'package:just_chat_app/features/user/domain/use_cases/login.dart';
// import 'package:just_chat_app/features/user/domain/use_cases/sign_up.dart';
// import 'package:just_chat_app/features/user/presentation/bloc/user_bloc.dart';
// import 'package:just_chat_app/features/user/presentation/pages/login_page.dart';
// import 'package:just_chat_app/features/user/presentation/pages/signup_page.dart';
// import 'package:just_chat_app/features/user/presentation/pages/splash_screen.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await init();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (_) => UserBloc(getIt<Login>(), getIt<IsAuthenticated>(), getIt<SignUp>())
//             ..add(CheckAuthentication()),
//         ),
//         BlocProvider(create: (_) => ProfileBloc()),
//         BlocProvider(create: (_) => ChatBloc()..add(const LoadChatsRequested())),
//       ],
//       child: MaterialApp(
//         title: 'Material App',
//         debugShowCheckedModeBanner: false,
//         initialRoute: '/splash',
//         routes: {
//           '/splash': (context) => SplashScreen(),
//           '/login': (context) => LoginPage(),
//           '/signup': (context) => SignupPage(),
//           '/home': (context) => HomePage(),
//           '/profile': (context) => ProfilePage(),
//           '/chats': (context) => ChatConversationPage(chat: ModalRoute.of(context)!.settings.arguments as Chat),
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_chat_app/core/di/injection.dart';
import 'package:just_chat_app/features/chat/data/models/chats_list_model.dart';
import 'package:just_chat_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:just_chat_app/features/chat/presentation/pages/chat_conversation_page.dart';
import 'package:just_chat_app/features/chat/presentation/pages/home_page.dart';
import 'package:just_chat_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:just_chat_app/features/profile/presentation/pages/profile_page.dart';
import 'package:just_chat_app/features/user/domain/use_cases/login.dart';
import 'package:just_chat_app/features/user/presentation/bloc/user_bloc.dart';
import 'package:just_chat_app/features/user/presentation/pages/login_page.dart';
import 'package:just_chat_app/features/user/presentation/pages/signup_page.dart';
import 'package:just_chat_app/features/user/presentation/pages/splash_screen.dart';

import 'features/user/domain/use_cases/is_authenticated.dart';
import 'features/user/domain/use_cases/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserBloc(getIt<Login>(), getIt<IsAuthenticated>(), getIt<SignUp>())
            ..add(CheckAuthentication()),
        ),
        BlocProvider(create: (_) => ProfileBloc()),
        BlocProvider(create: (_) => ChatBloc()..add(const LoadChatsRequested())),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserAuthenticated) {
              print("I am Authenitcated");
              return const HomePage(); // Authenticated users go to home
            } else if (state is UserFailure) {
              print("I am not alloww");
              return const LoginPage(); // Unauthenticated users go to login
            }
            else {
              print("Fuck you");
              return const LoginPage();
            }
          },
        ),
        routes: {
          '/splash': (context) => const SplashScreen(),
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignupPage(),
          '/home': (context) => const HomePage(),
          '/profile': (context) => const ProfilePage(),
          '/chats': (context) => ChatConversationPage(
            chat: ModalRoute.of(context)!.settings.arguments as Chat,
          ),
        },
      ),
    );
  }
}