import 'package:flutter/material.dart';
import 'package:myceleb/model/model.dart';
import 'package:myceleb/provider/requests_provider.dart';
import 'package:myceleb/screens/screens.dart';
import 'package:myceleb/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MyCelebRequestDetailsScreen extends StatefulWidget {
  final Request request;
  final UserModel celebrity;

  const MyCelebRequestDetailsScreen(
      {Key? key, required this.request, required this.celebrity})
      : super(key: key);

  @override
  _MyCelebRequestDetailsScreenState createState() =>
      _MyCelebRequestDetailsScreenState();
}

class _MyCelebRequestDetailsScreenState
    extends State<MyCelebRequestDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RequestsProvider>(context);
    final isCompleted = provider.completedRequests.contains(widget.request);
    final currentFan = provider.getCurrentFan;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      'My Celeb Request',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                UserCelebrityProfilePictureName(celebrity: widget.celebrity),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text('Request From Email Address',
                          style: kTitleTextStyle),
                      const SizedBox(height: 4),
                      Text('${currentFan.email}'),
                      const SizedBox(height: 15),
                      Text('Request From Name', style: kTitleTextStyle),
                      const SizedBox(height: 4),
                      Text(widget.request.requestFromName),
                      const SizedBox(height: 15),
                      Text('Request For Name', style: kTitleTextStyle),
                      const SizedBox(height: 4),
                      Text(widget.request.requestForName),
                      const SizedBox(height: 15),
                      Text('Message', style: kTitleTextStyle),
                      const SizedBox(height: 4),
                      Text(widget.request.message),
                      const SizedBox(height: 15),
                      Text('Request Date', style: kTitleTextStyle),
                      const SizedBox(height: 4),
                      Text(widget.request.requestDate),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                isCompleted
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              print('download video button pressed');

                              // TODO: implement download video code
                            },
                            style:
                                ElevatedButton.styleFrom(primary: Colors.black),
                            child: Text(
                              'Download video',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Leave a review',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          LeaveReview(),
                        ],
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          print('Edit request form button pressed');

                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditRequestScreen(
                                    request: widget.request,
                                    userModel: widget.celebrity,
                                  )));
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        child: Text(
                          'Edit Request',
                          style: TextStyle(color: Colors.white),
                        ),
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
