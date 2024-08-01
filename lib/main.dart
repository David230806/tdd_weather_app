import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_tdd/injection_container.dart';
import 'package:weather_tdd/presentation/bloc/weather_bloc.dart';
import 'package:weather_tdd/presentation/pages/weather_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<WeatherBloc>(),
      child: const MaterialApp(
        title: 'Flutter Demo',
        home: WeatherPage(),
      ),
    );
  }
}
