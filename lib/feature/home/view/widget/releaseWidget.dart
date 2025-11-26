import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/home/view/widgets/customcardwidget.dart';
import 'package:movie_app/features/home/view_model/release_cubit.dart';
import 'package:movie_app/features/home/view_model/release_state.dart';

class ReleaseWidget extends StatelessWidget {
  const ReleaseWidget({
    super.key,
    required this.releaseCubit,
  });

  final ReleaseCubit releaseCubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReleaseCubit, ReleaseState>(
      bloc: releaseCubit,
      builder: (context, state) {
        if (state is SucessState) {
          return Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("release"),
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
          return Center(
            child: Text(
              state.error,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  color: Colors.redAccent),
            ),
          );
        }
        return Container();
      },
    );
  }
}
