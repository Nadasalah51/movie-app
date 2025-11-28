import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/view/widget/popularWidget.dart';
import 'package:movie_app/feature/home/view/widget/releaseWidget.dart';
import 'package:movie_app/feature/home/view_model/popular/popular_cubit.dart';
import 'package:movie_app/feature/home/view_model/release/release_cubit.dart';



class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PopularCubit popularCubit;
  late ReleaseCubit releaseCubit;

  @override
  void initState() {
    super.initState();
    popularCubit = PopularCubit();
    popularCubit.getMovies();
    releaseCubit = ReleaseCubit();
    releaseCubit.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          PouplarWidget(popularCubit: popularCubit),
          SizedBox(
            height: 10,
          ),
          ReleaseWidget(releaseCubit: releaseCubit),
        ],
      ),
    ));
  }
}
