import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/view/widgets/customcardwidget.dart';
import 'package:movie_app/features/home/view_model/popular_cubit.dart';

import 'package:movie_app/features/home/view_model/popular_state.dart';

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
                  const Text("Popular"),
                  const SizedBox(height: 10),
                  SizedBox(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.66,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: state.results.length,
                      itemBuilder: (context, index) {
                        return CardPopularWidget(
                          image:
                              state.results[index].posterPath ?? "dummyImage",
                        );
                      },
                    ),
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
