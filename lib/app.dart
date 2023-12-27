import 'package:app/screens/screens.dart';
import "package:flutter/material.dart";

// import 'package:app/screens/home_screen.dart';

export 'package:app/app.dart';



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    // PushNotificationService.messagesStream.listen((message) {
    //   navigatorKey.currentState?.pushNamed('search', arguments: message);
    //   print('My app:$message');
    // });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mercadeo',
      initialRoute: 'home',
      navigatorKey: navigatorKey,
      routes: {
        // 'login' : ( _ ) => const LoginScreen(),
        'home' : ( _ ) =>  const LoadigScreen(),
        //  'register' : ( _ ) => RegisterScreen(),
        //  'petScreen' : ( _ ) => PetScreen(),
        //  'search':  (_) => SearchScreen(),
        //  'profile': ( _ ) => ProfileScreen(),
        //  'checking': ( _ ) => CheckAuthScreen()
      },
      // scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[300],
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.indigo
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigo,
          elevation: 0
        )
      ),
    );
  }
}