import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myceleb/model/model.dart';
import 'package:myceleb/provider/provider.dart';
import 'package:myceleb/screens/screens.dart';
import 'package:provider/provider.dart';

class LeaveReview extends StatefulWidget {
  @override
  _LeaveReviewState createState() => _LeaveReviewState();
}

class _LeaveReviewState extends State<LeaveReview> {
  late double _rating;

  int _ratingBarMode = 1;
  double _initialRating = 5.0;

  IconData? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _rating = _initialRating;
  }

  final messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RequestsProvider>(context);
    final currentFan = provider.getCurrentFan;
    final currentCeleb = provider.getCurrentCelebUser;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Rating: $_rating',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        _ratingBar(_ratingBarMode),
        ApplyToJoinTextFormField(
          controller: messageController,
          maxLength: 250,
          showPrefixIcon: false,
          labelText: 'Type review here',
        ),
        const SizedBox(height: 15),
        ElevatedButton(
          onPressed: () {
            print('leave a review button pressed');
            print(_rating);
            // TODO: add id to be equal to the request id
            final review = Reviews(
              // id: ,
              celebrityName: currentCeleb.name,
              fanName: currentFan.name,
              rating: _rating,
              message: messageController.text,
            );
            final reviewProvider =
                Provider.of<RequestsProvider>(context, listen: false);
            reviewProvider.addReview(review);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(primary: kLightGreen),
          child: Text(
            'Post Review',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _ratingBar(int mode) {
    return RatingBar.builder(
      initialRating: _initialRating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      unratedColor: Colors.amber.withAlpha(50),
      itemCount: 5,
      itemSize: 50.0,
      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _rating = rating;
        });
      },
      updateOnDrag: true,
    );
  }
}
