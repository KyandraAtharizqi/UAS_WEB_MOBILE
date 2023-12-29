// review_page.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:uasmobile/model/movie_model.dart';
import 'package:uasmobile/model/user_model.dart';
import 'package:uasmobile/model/review_model.dart';

class ReviewPage extends StatefulWidget {
  final Movie movie;
  final User user;

  ReviewPage({required this.movie, required this.user});

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController detailController = TextEditingController();
  List<Review> reviews = [];

  @override
  void initState() {
    super.initState();
    _fetchReviews();
  }

  Future<void> _fetchReviews() async {
    final apiUrl = 'http://34.128.67.212:5000/reviews';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final List<dynamic> reviewData = json.decode(response.body)['Review'];
        reviews = reviewData
            .map((json) => Review.fromJson(json))
            .where((review) => review.movieId == widget.movie.id.toString())
            .toList();
        setState(() {});
      } else {
        print('Error fetching reviews: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching reviews: $error');
    }
  }

  Future<void> submitReview() async {
    try {
      // Get the current user ID, username, and profile URL
      String currentUserId = widget.user.id.toString();
      String currentUsername = widget.user.usr;

      // Create a new review object with profile URL
      final Review review = Review(
        userId: currentUserId,
        username: currentUsername,
        movieId: widget.movie.id.toString(),
        subject: subjectController.text,
        detail: detailController.text,

      );

      final apiUrl = 'http://34.128.67.212:5000/reviews';

      // Send the new review to the server
      final postResponse = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'Review': review.toJson()}),
      );

      if (postResponse.statusCode == 200) {
        print('Review submitted successfully!');
        _fetchReviews(); // Refresh reviews after submission
        Navigator.pop(context); // Close the review submission popup
      } else {
        print('Error submitting review: ${postResponse.statusCode}');
      }
    } catch (error) {
      print('Error submitting review: $error');
    }
  }

  void _showReviewPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Write A Review'),
          content: Column(
            children: [
              TextField(
                controller: subjectController,
                decoration: InputDecoration(labelText: 'Subject'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: detailController,
                decoration: InputDecoration(labelText: 'Detail'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close the review submission popup
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: submitReview,
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reviews for ${widget.movie.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                reviews[index].username,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                reviews[index].subject.length > 100
                                    ? '${reviews[index].subject.substring(0, 100)}...'
                                    : reviews[index].subject,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                reviews[index].detail.length > 800
                                    ? '${reviews[index].detail.substring(0, 800)}...'
                                    : reviews[index].detail,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _showReviewPopup,
              child: Text('Write A Review'),
            ),
          ],
        ),
      ),
    );
  }
}
