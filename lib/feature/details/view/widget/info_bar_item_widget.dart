import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InfoBarItemWidget extends StatelessWidget {
  const InfoBarItemWidget({
    super.key,
    required this.icon,
    required this.infoText,
  });

  final String icon;
  final String infoText;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        SvgPicture.asset(
          icon,
          colorFilter: const ColorFilter.mode(
            Color(0xff92929D),
            BlendMode.srcIn,
          ),
        ),
        Text(
          infoText,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xff92929D),
          ),
        ),
      ],
    );
  }
}
