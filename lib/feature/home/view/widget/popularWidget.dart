import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/app_asset.dart';
import 'package:movie_app/feature/details/view/screen/details_screen.dart';
import 'package:movie_app/feature/home/view/widget/customcardwidget.dart';

import 'package:movie_app/feature/home/view_model/popular/popular_cubit.dart';
import 'package:movie_app/feature/home/view_model/popular/popular_state.dart';

class PouplarWidget extends StatelessWidget {
  const PouplarWidget({super.key, required this.popularCubit});

  final PopularCubit popularCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularCubit, PopularState>(
      bloc: popularCubit,
      builder: (context, state) {
        if (state is SucessState) {
          return Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Popular",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.66,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: state.popularResult.length,
                  itemBuilder: (context, index) {
                    return CardPopularWidget(
                      ontap: () {
                        Navigator.pushNamed(context, DetailsScreen.routeName);
                      },
                      image:
                          state.popularResult[index].posterPath ??
                          AppAsset.dummyImage,
                    );
                  },
                ),
              ],
            ),
          );
        }
        if (state is ErrorState) {
          return Text("Error");
        } else {
          return Container();
        }
      },
    );
  }
}
