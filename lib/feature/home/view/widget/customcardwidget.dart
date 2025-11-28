import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardPopularWidget extends StatelessWidget {
  CardPopularWidget({
    required this.image,
    required this.ontap,
    super.key,
  });
  String image;
  VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
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
      ),
    );
  }
}
