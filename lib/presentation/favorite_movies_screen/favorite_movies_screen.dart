import 'package:flutter/material.dart';
import 'package:movies__series_app/core/app_export.dart';
import 'package:movies__series_app/core/model/medium.dart';
import 'package:movies__series_app/core/services/favorite_service.dart';
import 'package:sizer/sizer.dart';

class FavoriteMoviesScreen extends StatefulWidget {
  const FavoriteMoviesScreen({super.key});

  @override
  State<FavoriteMoviesScreen> createState() => _FavoriteMovieScreenState();

}

class _FavoriteMovieScreenState extends State<FavoriteMoviesScreen> {
  final FavoriteService _favoriteService = FavoriteService();
  List<Medium> _favoriteMedia = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
  setState(() => _isLoading = true);


  final List<Medium> favoriteItems = await _favoriteService.getFavorites();
  
  if (mounted) {
    setState(() {
      _favoriteMedia = favoriteItems;
      _isLoading = false;
    });
  }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_favoriteMedia.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppTheme.mutedText.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.construction,
                  color: AppTheme.mutedText,
                  size: 64,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Sua lista está vazia.',
              style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
                color: AppTheme.contentWhite,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Text(
              'Adicione filmes e séries!',
              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.mutedText,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount:  _favoriteMedia.length,
      itemBuilder: (context, index) {
        final medium = _favoriteMedia[index];
        return ListTile(
          title: Text(medium.title, style: TextStyle(color: AppTheme.contentWhite)),
          subtitle: Text(medium.synopsis, style: TextStyle(color: AppTheme.mutedText), maxLines: 2),
          leading: medium.poster != null ? Image.network(medium.poster!, width: 15.w, fit: BoxFit.cover) : Container(width: 15.w, color: Colors.grey),
        );
      }, 
    );
  }
}
