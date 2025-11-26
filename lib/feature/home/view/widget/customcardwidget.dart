import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardPopularWidget extends StatelessWidget {
  CardPopularWidget({
    required this.image,
    super.key,
  });
  String image;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.network(
          image,
          height: 180,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
