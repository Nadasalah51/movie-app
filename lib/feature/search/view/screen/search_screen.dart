import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/utils/app_asset.dart';
import 'package:movie_app/core/utils/app_color.dart';
import 'package:movie_app/feature/details/view/screen/details_screen.dart';
import 'package:movie_app/feature/search/view/widget/custom_form_text_field.dart';
import 'package:movie_app/feature/search/view/widget/search_item_model_widget.dart';
import 'package:movie_app/feature/search/view_model/search_cubit.dart';
import 'package:movie_app/feature/search/view_model/search_state.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = 'SearchSceen';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Builder(
        builder: (context) {
          final cubit = BlocProvider.of<SearchCubit>(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('Search'),
              leading: Center(
                child: SvgPicture.asset(
                  AppAsset.menuIcon,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: 'Search',
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: SvgPicture.asset(
                        AppAsset.searchIcon,
                        width: 16,
                        height: 16,
                      ),
                    ),
                    action: TextInputAction.search,
                    onChanged: (value) {
                      if (value!.length >= 3) {
                        cubit.searchMovies(value);
                      }
                      if (value.isEmpty) {}
                    },
                  ),
                  Expanded(
                    child: BlocBuilder<SearchCubit, SearchState>(
                      builder: (context, state) {
                        if (state is InitialState) {
                          return Center(
                            child: SvgPicture.asset(
                              AppAsset.searchIcon,
                              width: 80,
                              height: 80,
                            ),
                          );
                        }
                        if (state is LoadingState) {
                          return Skeletonizer(
                            child: ListView.builder(
                              itemCount: 10,
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
                        if (state is ErrorState) {
                          return Center(
                            child: Text(
                              'No internet connection',
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                        }
                        if (state is SuccsessState) {
                          if (state.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                spacing: 10,
                                children: [
                                  Image.asset(AppAsset.noResultImage),
                                  SizedBox(
                                    width: 220,
                                    child: Text(
                                      "we are sorry, we can not find the movie :(",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodyLarge,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 220,
                                    child: Text(
                                      'Find your movie by Type title, categories, years, etc ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(color: AppColor.grayColor),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return ListView.builder(
                            itemCount: state.searchData!.results!.length,
                            itemBuilder: (context, index) {
                              final movie = state.searchData!.results![index];
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => DetailsScreen(
                                          selectedId: movie.id ?? 287,
                                        ),
                                      ),
                                    );
                                  },
                                  child: SearchItemModelWidget(
                                    title: movie.title ?? '',
                                    pathImage: movie.posterPath ?? '',
                                    vote: movie.voteAverage ?? 0.0,
                                    calender: movie.releaseDate ?? 'N/A',
                                    clock: movie.title ?? 'Unknown Title',
                                    ticket: movie.title ?? 'Action',
                                  ),
                                ),
                              );
                            },
                          );
                        }
                        return SizedBox();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
