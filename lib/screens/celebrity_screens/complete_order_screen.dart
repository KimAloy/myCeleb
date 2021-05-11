import 'package:flutter/material.dart';
import 'package:myceleb/model/model.dart';
import 'package:myceleb/provider/requests_provider.dart';
import 'package:provider/provider.dart';

class CompleteOrderScreen extends StatefulWidget {
  final Request request;

  const CompleteOrderScreen({
    Key? key,
    required this.request,
  }) : super(key: key);

  @override
  _CompleteOrderScreenState createState() => _CompleteOrderScreenState();
}

class _CompleteOrderScreenState extends State<CompleteOrderScreen> {
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
                      'My Fan\'s Request',
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
                Row(
                  children: [
                    currentFan.profileImage == ''
                        ? CircleAvatar(
                            child: Text(
                              '${currentFan.name[0]}',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.black38,
                          )
                        : CircleAvatar(
                            backgroundImage:
                                AssetImage(currentFan.profileImage!),
                            backgroundColor: Colors.transparent,
                          ),
                    const SizedBox(width: 5),
                    Text(
                      currentFan.name,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Text('Request From Email Address', style: kTitleTextStyle),
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
                const SizedBox(height: 15),
                Text(
                  'SWITCH TO YOUR CAMERA, RECORD A VIDEO THEN UPLOAD HERE. PLEASE KEEP IT UNDER 30 SECONDS',
                  style: kTitleTextStyle,
                ),
                const SizedBox(height: 4),
                uploadVideo(),
                const SizedBox(height: 20),
                isCompleted
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Completed',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            Icons.check_circle_outline,
                            size: 30,
                            color: kLightGreen,
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: completeOrder,
                            style:
                                ElevatedButton.styleFrom(primary: Colors.black),
                            child: Text(
                              'Complete Order',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector uploadVideo() {
    return GestureDetector(
      onTap: () {
        print('upload video tapped');
        // TODO: upload video to firebase firestore
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.grey[100],
        ),
        padding: EdgeInsets.symmetric(horizontal: 15),
        height: 50,
        // TODO: Add circle checkmark when upload is sucessful Johaness Milke
        child: Row(
          children: [
            Text(
              'Required',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            Spacer(),
            // Icon(Icons.file_upload),
            Icon(Icons.attach_file, color: Colors.black54),
          ],
        ),
      ),
    );
  }

  void completeOrder() {
    // TODO: validate if video is null, return dialog: "please upload video"
    final provider = Provider.of<RequestsProvider>(context, listen: false);
    provider.isCompleted(widget.request);
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('Order Completed!')));
    print('Complete order button pressed');
    Navigator.pop(context);
  }
}
