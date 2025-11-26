import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/utils/app_asset.dart';
import 'package:movie_app/feature/details/view/widget/info_bar_item_widget.dart';
import 'package:movie_app/feature/details/view/widget/poster_item_widget.dart';
import 'package:movie_app/feature/details/view_model/details_cubit.dart';
import 'package:movie_app/feature/details/view_model/details_state.dart';
import 'package:movie_app/feature/details/view_model/similar_cubit.dart';
import 'package:movie_app/feature/details/view_model/similar_state.dart'
    as similar;
import 'package:toastification/toastification.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.selectedId});
  final int selectedId;
  static const String routeName = 'DetailsScreen';

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late bool saved = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => DetailsCubit()..getDetailsFromAPI(widget.selectedId),
        ),
        BlocProvider(
          create: (_) => SimilarCubit()..getSimilarMovies(widget.selectedId),
        ),
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Center(
              child: SvgPicture.asset(
                AppAsset.arrowBackIcon,
                width: 30,
                height: 30,
              ),
            ),
          ),
          title: Text(
            'Detail',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          centerTitle: true,

          actions: [
            GestureDetector(
              onTap: savedOnTap,
              child: !saved
                  ? SvgPicture.asset(AppAsset.savedIcon, width: 30, height: 30)
                  : SvgPicture.asset(
                      AppAsset.savedMovieIcon,
                      width: 30,
                      height: 30,
                    ),
            ),
            const SizedBox(width: 12),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: BlocBuilder<DetailsCubit, DetailsState>(
                builder: (context, state) {
                  if (state is SuccessState) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: 15,
                      children: [
                        PosterItemWidget(
                          backDropPath: (state.movieDetails.backdropPath ?? ''),
                          posterPath: (state.movieDetails.posterPath ?? ''),
                          starIcon: AppAsset.starIcon,
                          movieTitle: state.movieDetails.title ?? '',
                          rating: state.movieDetails.voteAverage ?? 0.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 10,
                          children: [
                            InfoBarItemWidget(
                              icon: AppAsset.calenderIcon,
                              infoText:
                                  state.movieDetails.releaseDate?.substring(
                                    0,
                                    4,
                                  ) ??
                                  '',
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              width: 1.5,
                              height: 16,
                              color: Color(0xff696974),
                              child: Text(''),
                            ),
                            InfoBarItemWidget(
                              icon: AppAsset.clockIcon,
                              infoText: '${state.movieDetails.runtime} Minutes',
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              width: 1.5,
                              height: 16,
                              color: Color(0xff696974),
                              child: Text(''),
                            ),
                            InfoBarItemWidget(
                              icon: AppAsset.ticketIcon,
                              infoText:
                                  state.movieDetails.genres?[0].name ?? '',
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            state.movieDetails.overview ?? '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'similar',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        BlocBuilder<SimilarCubit, similar.SimilarState>(
                          builder: (context, similarState) {
                            if (similarState is similar.SuccessState) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 12),
                                child: Center(
                                  child: Wrap(
                                    children: similarState.similarMoviesResult
                                        .where(
                                          (movie) =>
                                              movie.posterPath != null &&
                                              movie.posterPath!.isNotEmpty,
                                        )
                                        .map(
                                          (movie) => GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      DetailsScreen(
                                                        selectedId: movie.id!,
                                                      ),
                                                ),
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                right: 16,
                                                bottom: 20,
                                              ),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      AppAsset.imagePrefix +
                                                      movie.posterPath!,

                                                  progressIndicatorBuilder:
                                                      (
                                                        context,
                                                        url,
                                                        downloadProgress,
                                                      ) => Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                              value:
                                                                  downloadProgress
                                                                      .progress,
                                                              color: Color(
                                                                0xff92929D,
                                                              ),
                                                            ),
                                                      ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                  height: 145,
                                                  width: 100,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              );
                            }
                            if (similarState is similar.ErrorState) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text(similarState.toString())],
                                ),
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff92929D),
                              ),
                            );
                          },
                        ),
                      ],
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
                  return Center(
                    child: CircularProgressIndicator(color: Color(0xff92929D)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void savedOnTap() {
    saved = !saved;
    setState(() {});

    toastification.show(
      context: context, // optional if you use ToastificationWrapper
      title: Text(
        saved ? 'Added To Watch List' : 'Removed from Watch List',
        style: Theme.of(context).appBarTheme.titleTextStyle,
      ),
      autoCloseDuration: const Duration(seconds: 2),
      alignment: Alignment.bottomCenter,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      foregroundColor: Color(0xffffffff),
    );
  }
}
