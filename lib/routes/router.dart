import 'package:go_router/go_router.dart';
import 'package:quiz/screens/auth/splashScreen.dart';
import 'package:quiz/screens/home/homeScreen.dart';
import 'package:quiz/screens/home/quizScreen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/quiz',
        builder: (context, state) => QuizScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
