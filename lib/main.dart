import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'utils/app_colors.dart';
import 'screens/splash_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
// 🆕 New imports for Profile and Events screens
import 'screens/profile_screen.dart';
import 'screens/my_events_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDHwpMZz33zSrGy1yE51Ddqej1gvVVi3fY",
        authDomain: "clubhub-a4d77.firebaseapp.com",
        projectId: "clubhub-a4d77",
        storageBucket: "clubhub-a4d77.firebasestorage.app",
        messagingSenderId: "344717597676",
        appId: "1:344717597676:web:5457cdec19f152d1f43ec9",
        measurementId: "G-7J4BBWM1YN",
      ),
    );
    print("✅ Firebase initialized successfully");
  } catch (e) {
    print("❌ Firebase initialization error: $e");
  }

  runApp(const ClubHubApp());
}

class ClubHubApp extends StatelessWidget {
  const ClubHubApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ClubHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
          secondary: AppColors.accent,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        // Note: The student property of HomeScreen must be null for the route to be const.
        '/home': (context) => const HomeScreen(student: null), 
        // ❌ REMOVED 'const' to fix the error in profile_screen.dart
        '/profile': (context) => ProfileScreen(), 
        // ❌ REMOVED 'const' to prevent a potential future error in MyEventsScreen
        '/my_events': (context) => MyEventsScreen(),
      },
    );
  }
}

/// 🔹 Helper: Sign up user and store info in Firestore
Future<void> signUpUser({
  required String name,
  required String email,
  required String password,
}) async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    // 1️⃣ Create user with email & password
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String uid = userCredential.user!.uid;

    // 2️⃣ Save user data in Firestore
    await _firestore.collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });

    print("✅ User registered and data saved in Firestore");

  } catch (e) {
    print("❌ Sign up error: $e");
  }
}