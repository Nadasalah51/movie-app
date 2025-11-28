import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie-app/feature/home/view/widget/customcardwidget.dart';
import 'package:movie-app/feature/home/view_model/popular/popular_cubit.dart';
import 'package:movie-app/core/utils/app_asset.dart';
import 'package:movie-app/feature/home/view_model/popular/popular_state.dart';

class PouplarWidget extends StatelessWidget {
  const PouplarWidget({
    super.key,
    required this.popularCubit,
  });

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
                  const Text("Popular",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 10),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.66,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: state.results.length,
                    itemBuilder: (context, index) {
                      return CardPopularWidget(
                        ontap: () {
                          Navigator.pushNamed(context, DetailsScreen.routeName);
                        },
                        image: state.results[index].posterPath ??
                            AppAsset.dummyImage,
                      );
                    },
                  ),
                ],
              ));
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

String dummyImage =
    'https://images.theconversation.com/files/651621/original/file-20250226-32-jxjhmy.jpg?ixlib=rb-4.1.0&rect=0%2C0%2C5991%2C3997&q=20&auto=format&w=320&fit=clip&dpr=2&usm=12&cs=strip';
