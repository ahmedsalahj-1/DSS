import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/auth/sign_in_screen.dart';
import 'screens/auth/sign_up_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/crop_recommendation/crop_form_screen.dart';
import 'screens/crop_recommendation/result_screen.dart';
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Crop Recommendation App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF4CAF50),
                brightness: Brightness.light,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF4CAF50),
                brightness: Brightness.dark,
              ),
              textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
              useMaterial3: true,
            ),
            themeMode: themeProvider.themeMode,
            initialRoute: '/signin',
            routes: {
              '/signin': (context) => const SignInScreen(),
              '/signup': (context) => const SignUpScreen(),
              '/home': (context) => const HomeScreen(),
              '/crop-form': (context) => const CropFormScreen(),
              '/result': (context) => const ResultScreen(),
            },
          );
        },
      ),
    );
  }
}
