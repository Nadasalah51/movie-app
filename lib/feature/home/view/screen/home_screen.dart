import 'package:flutter/material.dart';
import 'package:movie_app/feature/home/view/widget/popularWidget.dart';
import 'package:movie_app/feature/home/view/widget/releaseWidget.dart';
import 'package:movie_app/feature/home/view_model/popular/popular_cubit.dart';
import 'package:movie_app/feature/home/view_model/release/release_cubit.dart';



class HomeScreen extends StatefulWidget {
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/constants/app_const_api.dart';
import 'package:movie_app/core/utils/app_color.dart';
import 'package:movie_app/feature/details/view/screen/details_screen.dart';
import 'package:movie_app/feature/home/view/widget/container_with_index.dart';
import 'package:movie_app/feature/home/view_model/recommendation_cubit.dart';
import 'package:movie_app/feature/home/view_model/recommendation_state.dart';

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
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final RecommendationCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = RecommendationCubit();
    cubit.getResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
      appBar: AppBar(
        title: Text(
          'What do you want to watch?',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        centerTitle: false,
      ),

      body: Column(
        children: [
          PouplarWidget(popularCubit: popularCubit),
          SizedBox(
            height: 10,
          ),
          ReleaseWidget(releaseCubit: releaseCubit),
          BlocBuilder<RecommendationCubit, RecommendationState>(
            bloc: cubit,
            builder: (context, state) {
              if (state is ErrorRecommendationState) {
                return Center(
                  child: Text(
                    'No internet Connection',
                    style: TextStyle(color: AppColor.orangeColor),
                  ),
                );
              }
              if (state is SuccessRecommendationState) {
                return SizedBox(
                  height: 250,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    itemBuilder: (context, index) {
                      return ContainerWithIndex(
                        pathImage:
                            "${AppConstApi.imageBaseUrl}${state.results[index].posterPath}",
                        index: index + 1,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailsScreen(
                                selectedId: state.results[index].id ?? 287,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    itemCount: state.results.length,
                    separatorBuilder: (context, index) => SizedBox(width: 12),
                  ),
                );
              }
              return SizedBox();
            },
          ),
        ],
      ),
    ));
  }
}
