// movie_detail_page.dart
import 'package:flutter/material.dart';
import 'package:uasmobile/model/movie_model.dart';
import 'package:uasmobile/controllers/navigation_manager.dart';

class MovieDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              child: Image.network(
                movie.posterUrl,
                errorBuilder: (context, error, stackTrace) {
                  return Image.network(
                    'https://sternbergclinic.com.au/wp-content/uploads/2020/03/placeholder.png',
                    height: 200,
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                movie.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Year: ${movie.year}'),
                Text('Genres: ${movie.genres.join(", ")}'),
                Text('Runtime: ${movie.runtime} minutes'),
                Text('Directors: ${movie.director}'),
                Text('Actors: ${movie.actors}'),
                Text('Plot: ${movie.plot}'),
              ],
            ),
            SizedBox(height: 16),
              ElevatedButton(
              onPressed: () {
                // Pass the movie to the review page
                NavigationManager.navigateToReviewPage(context, movie);
              },
              child: Text('See Reviews'),
            ),
          ],
        ),
      ),
    );
  }
}


