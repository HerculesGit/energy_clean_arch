import 'package:flutter/material.dart';

import '../../config/themes.dart';

class TitleLegend extends StatelessWidget {
  final String title;
  final String legend;
  final Color? titleColor;

  const TitleLegend(
      {Key? key, required this.title, required this.legend, this.titleColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title,
            style: AppTheme.titleStyle
                .copyWith(color: titleColor ?? AppTheme.whiteColor)),
        const SizedBox(height: 16.0 / 2),
        Text(legend, style: AppTheme.textStyle),
      ],
    );
  }
}
