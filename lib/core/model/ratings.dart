import 'dart:convert';

class Ratings {
  final double averageRating;
  final int totalReviews;
  final List<RatingBreakdown> breakdown;

  Ratings({
    required this.averageRating,
    required this.totalReviews,
    required this.breakdown,
  });

  factory Ratings.fromJson(Map<String, dynamic> json) {

    final rawAverageRating = json['averageRating'];
    final int totalReviewsValue = json['totalReviews'];
    final List<dynamic> rawBreakdownList = json['breakdown'];

    final double averageRatingValue = rawAverageRating.toDouble();

    final List<RatingBreakdown> breakdownItems = [];

    for(var item in rawBreakdownList) {
      
      final breakdownItem = RatingBreakdown.fromJson(item);

      breakdownItems.add(breakdownItem);
    }

    return Ratings(
      averageRating: averageRatingValue,
      totalReviews: totalReviewsValue,
      breakdown: breakdownItems
    );
  }
}

class RatingBreakdown {
  final int stars;
  final double percentage;

  RatingBreakdown ({
    required this.stars,
    required this.percentage,
  });

  factory RatingBreakdown.fromJson(Map<String, dynamic> json) {
    final int starsValue = json['stars'];
    final num rawPercentage = json['percentage'];

    final double percentageValue = rawPercentage.toDouble();

    return RatingBreakdown(
      stars: starsValue, 
      percentage: percentageValue,
      );
  }
}