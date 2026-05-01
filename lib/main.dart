import 'package:flutter/material.dart';
import 'Screen/Beranda.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends  StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        },
      ),
      debugShowCheckedModeBanner: false,
      title: 'MiniProject1',
      theme: ThemeData(
          useMaterial3: true,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
      home : const Beranda(),
    );
  }
}