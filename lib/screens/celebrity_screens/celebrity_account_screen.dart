import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:myceleb/provider/requests_provider.dart';
import 'package:myceleb/screens/screens.dart';
import 'package:myceleb/widgets/widgets.dart';
import 'package:provider/provider.dart';

class CelebrityAccountScreen extends StatelessWidget {
  const CelebrityAccountScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RequestsProvider>(context);
    final currentUser = provider.getCurrentCelebUser;
    final isCompleted = provider.completedRequests;
    final reviews = provider.currentCelebReviews;
    final currentCelebName = provider.getCurrentCelebUser.name;
    final completedTasks = isCompleted
        .where((task) => task.celebrityName == currentCelebName)
        .toList();
    final isNotCompleted = provider.requests;
    final incompleteTasks = isNotCompleted
        .where((task) => task.celebrityName == currentCelebName)
        .toList();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                MyAppBar(balance: currentUser.accountBalance),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      currentUser.name,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 5),
                    CircleAvatar(
                      backgroundImage: AssetImage(currentUser.profileImage!),
                      backgroundColor: Colors.transparent,
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  'Fan Requests',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                incompleteTasks.isEmpty
                    ? Text(
                        'No new requests available',
                        style: TextStyle(fontSize: 16, color: Colors.black45),
                        textAlign: TextAlign.center,
                      )
                    : _CelebRequestListWidget(),
                const SizedBox(height: 30),
                Text(
                  'Completed Requests',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),

                completedTasks.isEmpty
                    ? Text(
                        'No completed requests yet',
                        style: TextStyle(fontSize: 16, color: Colors.black45),
                        textAlign: TextAlign.center,
                      )
                    : _CompletedRequestListWidget(),
                const SizedBox(height: 30),
                Text(
                  'My Reviews',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                // TODO: Future: add total number of reviews and average rating
                reviews.isEmpty
                    ? Text(
                        'No reviews available',
                        style: TextStyle(fontSize: 16, color: Colors.black45),
                        textAlign: TextAlign.center,
                      )
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        separatorBuilder: (BuildContext context, int index) =>
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
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              RatingBarIndicator(
                                rating: review.rating,
                                // rating: celeb.rating,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 15,
                                direction: Axis.horizontal,
                              ),
                              // celeb.message!.isEmpty
                              //     ? const SizedBox.shrink()
                              //     : Text('${celeb.message}')
                              review.message!.isEmpty
                                  ? const SizedBox.shrink()
                                  : Text('${review.message}')
                            ],
                          );
                        },
                      ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CelebRequestListWidget extends StatelessWidget {
  const _CelebRequestListWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RequestsProvider>(context);
    final isNotCompleted = provider.requests;
    final currentCeleb = provider.getCurrentCelebUser;
    final requests = isNotCompleted
        .where((task) => task.celebrityName == currentCeleb.name)
        .toList();
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 40),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      itemBuilder: (BuildContext context, int index) {
        final request = requests[index];

        return GestureDetector(
          onTap: () {
            print('FanRequestsScreen: going to fanRequestDetailScreen');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return CompleteOrderScreen(request: request);
                },
              ),
            );
          },
          child: Row(
            children: [
              request.requesterProfilePicture == ''
                  ? CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Text('${(request.requestFromName[0])}'),
                    )
                  : CircleAvatar(
                      backgroundImage:
                          AssetImage(request.requesterProfilePicture),
                      backgroundColor: Colors.transparent,
                    ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${request.requestFromName}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${request.message}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Icon(Icons.keyboard_arrow_right),
            ],
          ),
        );
      },
    );
  }
}

class _CompletedRequestListWidget extends StatelessWidget {
  const _CompletedRequestListWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RequestsProvider>(context);
    final isCompleted = provider.completedRequests;
    final currentCeleb = provider.getCurrentCelebUser;
    final completedTasks = isCompleted
        .where((task) => task.celebrityName == currentCeleb.name)
        .toList();
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 40),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: completedTasks.length,
      itemBuilder: (BuildContext context, int index) {
        final request = completedTasks[index];
        return GestureDetector(
          onTap: () {
            print('FanRequestsScreen: going to fanRequestDetailScreen');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return CompleteOrderScreen(request: request);
                },
              ),
            );
          },
          child: Row(
            children: [
              request.requesterProfilePicture == ''
                  ? CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Text('${(request.requestFromName[0])}'),
                    )
                  : CircleAvatar(
                      backgroundImage:
                          AssetImage(request.requesterProfilePicture),
                      backgroundColor: Colors.transparent,
                    ),
              const SizedBox(width: 6),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${request.requestFromName}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${request.message}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              Icon(Icons.keyboard_arrow_right),
            ],
          ),
        );
      },
    );
  }
}
