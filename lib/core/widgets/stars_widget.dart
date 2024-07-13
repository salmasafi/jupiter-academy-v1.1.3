import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class StarsWidget extends StatelessWidget {
  final double initialRating;
  const StarsWidget({
    super.key,
    required this.initialRating,
  });

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      itemSize: 27,
      initialRating: initialRating,
      minRating: 0,
      direction: Axis.horizontal,
      allowHalfRating: true,
      ignoreGestures: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 3),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }
}
