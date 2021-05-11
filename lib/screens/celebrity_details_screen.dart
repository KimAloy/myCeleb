import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myceleb/model/model.dart';
import 'package:myceleb/provider/provider.dart';
import 'package:myceleb/screens/screens.dart';
import 'package:provider/provider.dart';

class CelebrityDetailsPage extends StatelessWidget {
  final UserModel celebrity;

  const CelebrityDetailsPage({Key? key, required this.celebrity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RequestsProvider>(context);
    final fan = provider.getCurrentFan;
    List reviews = provider.reviews
        .where((review) => review.celebrityName == celebrity.name)
        .toList();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: 500,
                  child:
                      Image.asset(celebrity.profileImage!, fit: BoxFit.cover),
                ),
                Positioned(
                    top: 25,
                    left: 10,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                      onPressed: () => Navigator.of(context).pop(),
                    )),
                Positioned(
                  bottom: 10,
                  left: 15,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${celebrity.name}',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        '${celebrity.category![0]}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Price', style: kTitleTextStyle),
                  const SizedBox(height: 2),
                  Text('Ugx ${numberCommaFormatter.format(celebrity.price)}'),
                  const SizedBox(height: 10),
                  Text('Description', style: kTitleTextStyle),
                  const SizedBox(height: 4),
                  Text('${celebrity.description}'),
                  const SizedBox(height: 10),
                  Text('Estiamted Delivery Time', style: kTitleTextStyle),
                  const SizedBox(height: 4),
                  Text(celebrity.estimatedDeliveryTime == 1
                      ? '${celebrity.estimatedDeliveryTime} Day'
                      : '${celebrity.estimatedDeliveryTime} Days'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MakeRequestScreen(
                                celebrity: celebrity,
                                fan: fan,
                              )));
                      print('Make request button pressed');
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    child: Text(
                      'Make Request',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  reviews.isEmpty
                      ? const SizedBox.shrink()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              'Reviews',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 15),
                            ListView.separated(
                              padding: EdgeInsets.zero,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      Divider(height: 20),
                              shrinkWrap: true,
                              reverse: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: reviews.length,
                              itemBuilder: (BuildContext context, int index) {
                                final review = reviews[index];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      review.fanName,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    RatingBarIndicator(
                                      rating: review.rating,
                                      itemBuilder: (context, index) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      itemCount: 5,
                                      itemSize: 15,
                                      direction: Axis.horizontal,
                                    ),
                                    review.message!.isEmpty
                                        ? const SizedBox.shrink()
                                        : Text('${review.message}')
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
