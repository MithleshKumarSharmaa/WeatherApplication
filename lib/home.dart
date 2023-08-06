import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/weather_bloc/weather_bloc.dart';
import 'package:weather_app/weather_bloc/weather_event.dart';
import 'package:weather_app/weather_bloc/weather_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = WeatherBloc();
    final weatherController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          'Weather App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        bloc: weatherBloc,
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Welcome,",
                      style: TextStyle(fontSize: 25, color: Colors.amber),
                    ),
                    Text(
                      "Location Weather...",
                      style: TextStyle(fontSize: 29, color: Colors.green),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 30),
                    TextFormField(
                      controller: weatherController,
                      decoration: const InputDecoration(hintText: 'Enter City'),
                    ),
                    SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        weatherBloc.add(
                            FetchWeatherEvent(weatherController.text.trim()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        fixedSize: Size(150, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: Text(
                        "Temperature",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Row(
                      children: const [
                        Expanded(
                          child: Divider(
                            thickness: 2,
                            endIndent: 5,
                            indent: 5,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          "Show",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.deepOrange,
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 2,
                            endIndent: 5,
                            indent: 5,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    state is WeatherLoadingState
                        ? CircularProgressIndicator()
                        : state is WeatherLoadedState
                            ? Text(
                                '${state.weatherData.main.temp.toString()}° C',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              )
                            : state is WeatherLoadingFailureState
                                ? Text(state.error)
                                : SizedBox.shrink()
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
