import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movie_app/core/utils/app_asset.dart';
import 'package:movie_app/core/utils/app_color.dart';
import 'package:movie_app/feature/details/view/screen/details_screen.dart';
import 'package:movie_app/feature/saved/view_model/saved_cubit.dart';
import 'package:movie_app/feature/saved/view_model/saved_state.dart';
import 'package:movie_app/feature/search/view/widget/search_item_model_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SavedScreen extends StatelessWidget {
  static const String routeName = 'SavedSceen';
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watch list'),
        leading: Center(
          child: SvgPicture.asset(AppAsset.menuIcon, width: 20, height: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          children: [
            Expanded(
              child: BlocProvider(
                create: (context) => SavedCubit(),
                child: Builder(
                  builder: (context) {
                    return BlocBuilder<SavedCubit, SavedState>(
                      builder: (context, state) {
                        if (state is LoadingState) {
                          return Skeletonizer(
                            child: ListView.builder(
                              itemCount: 5,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: SearchItemModelWidget(
                                    title: 'movie.title',
                                    pathImage: AppAsset.dummyImage,
                                    vote: 0.0,
                                    calender: 'N/A',
                                    clock: 'Unknown Title',
                                    ticket: 'Action',
                                  ),
                                );
                              },
                            ),
                          );
                        }
                        if (state is Errorstate) {
                          return Center(
                            child: Text(
                              'No internet connection',
                              style: TextStyle(color: AppColor.redColor),
                            ),
                          );
                        }
                        if (state is EmptyState) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(AppAsset.boxImage),
                                const SizedBox(height: 16),
                                Text(
                                  'There is no movie yet!',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Find your movie by Type title',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.displayMedium,
                                ),
                              ],
                            ),
                          );
                        }
                        if (state is SuccessState) {
                          return ListView.builder(
                            itemCount: state.movies.length,
                            itemBuilder: (context, index) {
                              final movie = state.movies[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: InkWell(
                                  onTap: () async {
                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsScreen(selectedId: movie.id),
                                      ),
                                    );
                                    context.read<SavedCubit>().getSavedMovies();
                                  },
                                  child: SearchItemModelWidget(
                                    title: movie.title,
                                    pathImage: movie.image,
                                    vote: movie.rate,
                                    calender: movie.date,
                                    clock: movie.title,
                                    ticket: movie.title,
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
