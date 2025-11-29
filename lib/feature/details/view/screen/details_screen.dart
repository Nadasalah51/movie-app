import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movie_app/core/constants/app_const_api.dart';
import 'package:movie_app/core/utils/app_asset.dart';
import 'package:movie_app/core/utils/app_color.dart';
import 'package:movie_app/feature/saved/data/database/sql_database.dart';
import 'package:movie_app/feature/saved/data/model/saved_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:toastification/toastification.dart';
import 'package:movie_app/feature/details/view/widget/info_bar_item_widget.dart';
import 'package:movie_app/feature/details/view/widget/poster_item_widget.dart';
import 'package:movie_app/feature/details/view_model/details_cubit.dart';
import 'package:movie_app/feature/details/view_model/details_state.dart';
import 'package:movie_app/feature/details/view_model/similar_cubit.dart';
import 'package:movie_app/feature/details/view_model/similar_state.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.selectedId});
  final int selectedId;
  static const String routeName = 'DetailsScreen';

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late bool saved = false;
  late SavedModel savedMovie = SavedModel(
    id: 0,
    date: '',
    ticket: '',
    image: '',
    rate: 0,
    title: '',
  );
  @override
  void initState() {
    super.initState();
    _checkIfSaved();
  }

  @override
  Future<void> _checkIfSaved() async {
    final bool isSaved = await SqlHelper().isMovieSaved(widget.selectedId);
    setState(() {
      saved = isSaved;
    });
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
              child: Column(
                children: [
                  BlocBuilder<DetailsCubit, DetailsState>(
                    builder: (context, state) {
                      if (state is SuccessDetailsState) {
                        savedMovie.id = state.movieDetails.id ?? 0;
                        savedMovie.date =
                            state.movieDetails.releaseDate?.substring(0, 4) ??
                            '';
                        savedMovie.title = state.movieDetails.title ?? '';
                        savedMovie.image = state.movieDetails.posterPath ?? '';
                        savedMovie.rate = state.movieDetails.voteAverage ?? 0;
                        savedMovie.ticket = state.movieDetails.title ?? '';
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 15,
                          children: [
                            PosterItemWidget(
                              backDropPath:
                                  (state.movieDetails.backdropPath ?? ''),
                              posterPath: (state.movieDetails.posterPath ?? ''),
                              starIcon: AppAsset.starIcon,
                              movieTitle: state.movieDetails.title ?? '',
                              rating: state.movieDetails.voteAverage ?? 0.0,
                              isLoading: false,
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
                                  color: AppColor.grayColor,
                                  child: Text(''),
                                ),
                                InfoBarItemWidget(
                                  icon: AppAsset.clockIcon,
                                  infoText:
                                      '${state.movieDetails.runtime} Minutes',
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  width: 1.5,
                                  height: 16,
                                  color: AppColor.grayColor,
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
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                state.movieDetails.overview ?? '',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Text(
                                'Similar',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        );
                      }
                      if (state is ErrorSimilarState) {
                        return Center(
                          child: Text(
                            'No internet connection',
                            style: TextStyle(color: AppColor.redColor),
                          ),
                        );
                      }
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 15,
                        children: [
                          PosterItemWidget(
                            starIcon: AppAsset.starIcon,
                            movieTitle: dummyText,
                            rating: 0.0,
                            isLoading: true,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              InfoBarItemWidget(
                                icon: AppAsset.calenderIcon,
                                infoText: '',
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                width: 1.5,
                                height: 16,
                                color: AppColor.grayColor,
                                child: Text(''),
                              ),
                              InfoBarItemWidget(
                                icon: AppAsset.clockIcon,
                                infoText: '',
                              ),
                              Container(
                                margin: EdgeInsets.all(10),
                                width: 1.5,
                                height: 16,
                                color: AppColor.grayColor,
                                child: Text(''),
                              ),
                              InfoBarItemWidget(
                                icon: AppAsset.ticketIcon,
                                infoText: '',
                              ),
                            ],
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              '',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Similar',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  BlocBuilder<SimilarCubit, SimilarState>(
                    builder: (context, similarState) {
                      if (similarState is SuccessSimilarState) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 12, top: 10),
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
                                            builder: (context) => DetailsScreen(
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
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl:
                                                AppConstApi.imageBaseUrl +
                                                movie.posterPath!,
                                            progressIndicatorBuilder:
                                                (
                                                  context,
                                                  url,
                                                  downloadProgress,
                                                ) => Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                        value: downloadProgress
                                                            .progress,
                                                        color: AppColor
                                                            .backGroundColor,
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
                      if (similarState is ErrorSimilarState) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(similarState.toString())],
                          ),
                        );
                      }
                      return Center(
                        child: Skeletonizer(
                          enabled: true,
                          effect: ShimmerEffect(
                            baseColor: AppColor.backGroundColor,
                            highlightColor: AppColor.grayColor,
                            duration: Duration(seconds: 1),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 24,
                                  bottom: 24,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 12,
                                  children: [
                                    Image.asset(
                                      AppAsset.dummyImage,
                                      height: 145,
                                      width: 100,
                                      fit: BoxFit.contain,
                                    ),
                                    Image.asset(
                                      AppAsset.dummyImage,
                                      height: 145,
                                      width: 100,
                                      fit: BoxFit.contain,
                                    ),
                                    Image.asset(
                                      AppAsset.dummyImage,
                                      height: 145,
                                      width: 100,
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  top: 24,
                                  bottom: 24,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 12,
                                  children: [
                                    Image.asset(
                                      AppAsset.dummyImage,
                                      height: 145,
                                      width: 100,
                                      fit: BoxFit.contain,
                                    ),
                                    Image.asset(
                                      AppAsset.dummyImage,
                                      height: 145,
                                      width: 100,
                                      fit: BoxFit.contain,
                                    ),
                                    Image.asset(
                                      AppAsset.dummyImage,
                                      height: 145,
                                      width: 100,
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void savedOnTap() async {
    final bool previousSavedState = saved;
    setState(() {
      saved = !saved;
    });
    try {
      if (saved == true) {
        await SqlHelper().addMovie(savedMovie);
        _showToast(true);
      } else {
        await SqlHelper().deleteMovie(savedMovie.id);
        _showToast(false);
      }
    } catch (e) {
      setState(() {
        saved = previousSavedState;
      });
    }
  }

  void _showToast(bool? success) {
    String message;
    Color? foregroundColor;

    if (success == true) {
      message = 'Added To Watch List';
      foregroundColor = successColor;
    } else if (success == false) {
      message = 'Removed from Watch List';
      foregroundColor = successColor;
    } else {
      message = 'Operation failed. Try again.';
      foregroundColor = errorColor;
    }

    toastification.show(
      context: context,
      title: Text(message, style: TextStyle(color: foregroundColor)),
      autoCloseDuration: const Duration(seconds: 2),
      alignment: Alignment.bottomCenter,
      backgroundColor: AppColor.whiteColor,
    );
  }
}

const String dummyText = 'dummy';
