import 'package:flutter/material.dart';
import 'package:movies__series_app/core/services/favorite_service.dart';
import 'package:sizer/sizer.dart';

import '../../core/model/medium.dart';
import '../../core/app_export.dart';
import './widgets/action_buttons_widget.dart';
import './widgets/cast_section_widget.dart';
import './widgets/genre_chips_widget.dart';
import './widgets/hero_section_widget.dart';
import './widgets/streaming_platforms_widget.dart';
import './widgets/synopsis_section_widget.dart';
import './widgets/user_ratings_widget.dart';


class ContentDetailScreen extends StatefulWidget {
  final Medium medium;

  const ContentDetailScreen({
    super.key,
    required this.medium,
  });

  @override
  State<ContentDetailScreen> createState() => _ContentDetailScreenState();
}


class _ContentDetailScreenState extends State<ContentDetailScreen> {
  final FavoriteService _favoriteService = FavoriteService();
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    bool isFav = await _favoriteService.isFavorite(widget.medium.id);
    setState(() {
      _isFavorite = isFav;
    });
  }

  Future<void> _toggleFavorite() async {
    if(_isFavorite) {
      await _favoriteService.removeFavorite(widget.medium.id);
    } else {
      await _favoriteService.addFavorite(widget.medium);
    }
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryDark,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: AppTheme.primaryDark.withValues(alpha: 0.95),
            elevation: 0,
            pinned: true,
            expandedHeight: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: AppTheme.contentWhite,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              widget.medium.title,
              style: AppTheme.darkTheme.textTheme.titleMedium?.copyWith(
                color: AppTheme.contentWhite,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  _isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: _isFavorite ? AppTheme.accentColor : AppTheme.contentWhite,
                  size: 24,
                ),
                onPressed: _toggleFavorite,
                ),
              IconButton(
                icon: Icon(
                  Icons.share,
                  color: AppTheme.contentWhite,
                  size: 24,
                ),
                onPressed: () {
                  
                }),
              SizedBox(width: 2.w),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeroSectionWidget(
                  contentData: widget.medium,
                ),
                GenreChipsWidget(
                  genres: widget.medium.genres,
                ),
                SynopsisSectionWidget(
                  synopsis: widget.medium.synopsis,
                ),
                SizedBox(height: 2.h),
                CastSectionWidget(
                  mediumId: widget.medium.id,
                ),
                SizedBox(height: 2.h),
                StreamingPlatformsWidget(
                  platforms: widget.medium.streamingPlatforms,
                ),
                SizedBox(height: 2.h),
                UserRatingsWidget(
                  mediumId: widget.medium.id,
                ),
                SizedBox(height: 2.h),
                ActionButtonsWidget(
                  isInWatchlist: false,
                  onWatchlistToggle: () {
                    
                  },
                  onShare: () {
                    
                  },
                ),
                SizedBox(height: 4.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}