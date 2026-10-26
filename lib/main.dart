import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:linker/generated/l10n.dart';
import 'package:linker/splach_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xsryxlyhgrgxglifqxjf.supabase.co', // Replace with your Supabase URL
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhzcnl4bHloZ3JneGdsaWZxeGpmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQyMDk2MDYsImV4cCI6MjA0OTc4NTYwNn0.PB7vFUpAH13feYlB_0I3an3cwiipCP3O6XybO9WArtA', // Replace with your Supabase anon key
  );
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('en'),
      localizationsDelegates: [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
      home:  SplashScreen(),
    );
  }
}