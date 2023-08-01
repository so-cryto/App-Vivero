import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // add this dependency
import 'package:productos_app/config/router/app_router.dart';
import 'package:productos_app/config/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(child: MyApp()) 
  );
} 
class MyApp extends ConsumerWidget { 
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) { 
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme:AppTheme().getTheme(),
    );
  }
}