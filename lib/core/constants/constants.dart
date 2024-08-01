class Urls {
  static const String baseUrl = "https://api.openweathermap.org/data/2.5";
  static const String apiKey = "328f7f7754d9fed03a57cd62b48b1b82";
  static String currentWeatherByName(String city) =>
      "$baseUrl/weather?q=$city&appid=$apiKey";
  static String weatherIcon(String iconCode) =>
      "https://openweathermap.org/img/wn/$iconCode@2x.png";
}
