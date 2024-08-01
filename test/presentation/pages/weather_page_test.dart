import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_tdd/domain/entities/weather.dart';
import 'package:weather_tdd/presentation/bloc/weather_bloc.dart';
import 'package:weather_tdd/presentation/pages/weather_page.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testWeather = WeatherEntity(
    cityName: "America/Chicago",
    description: "broken clouds",
    humidity: 89,
    iconCode: '04d',
    main: "Clouds",
    pressure: 1014,
    temperature: 292.55,
  );

  testWidgets(
    "text field should trigger state to change from empty to loading",
    (tester) async {
      when(() => mockWeatherBloc.state).thenReturn(() => WeatherInitial());

      await tester.pumpWidget(_makeTestableWidget(const WeatherPage()));

      var textField = find.byType(TextField);

      expect(textField, findsOneWidget);

      await tester.enterText(textField, "New York");
      await tester.pump();

      expect(find.text("New York"), findsOneWidget);
    },
  );

  testWidgets(
    "should show progress indicator when state is loading",
    (tester) async {
      when(() => mockWeatherBloc.state).thenReturn(() => WeatherLoading());

      await tester.pumpWidget(_makeTestableWidget(const WeatherPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    "should show widget contain weather data when state is loaded",
    (tester) async {
      when(() => mockWeatherBloc.state)
          .thenReturn(() => const WeatherLoaded(testWeather));

      await tester.pumpWidget(_makeTestableWidget(const WeatherPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
