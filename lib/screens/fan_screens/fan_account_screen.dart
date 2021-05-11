import 'package:flutter/material.dart';
import 'package:myceleb/provider/requests_provider.dart';
import 'package:myceleb/screens/screens.dart';
import 'package:myceleb/widgets/widgets.dart';
import 'package:provider/provider.dart';

class FanAccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RequestsProvider>(context);
    final completed = provider.completedRequests;
    final celebritiesList = provider.celebritiesList;
    final currentFan = provider.getCurrentFan;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 15),
                MyAppBar(balance: currentFan.accountBalance),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      currentFan.name,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 5),
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
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  'Available downloads',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                completed.isEmpty
                    ? Text(
                        'No downloads available',
                        style: TextStyle(fontSize: 16, color: Colors.black45),
                        textAlign: TextAlign.center,
                      )
                    : ListView.separated(
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(height: 40),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: completed.length,
                        itemBuilder: (BuildContext context, int index) {
                          final request = completed[index];
                          List storeCelebImage = celebritiesList
                              .where((i) => i.name
                                  .contains(completed[index].celebrityName!))
                              .toList();
                          return GestureDetector(
                            onTap: () {
                              print(
                                  'FanRequestsScreen: going to fanRequestDetailScreen');
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return MyCelebRequestDetailsScreen(
                                  request: request,
                                  celebrity: storeCelebImage[0],
                                );
                              }));
                            },
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: AssetImage(
                                      storeCelebImage[0].profileImage),
                                  backgroundColor: Colors.transparent,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${request.requestFromName}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        '${request.message}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.download_sharp),
                              ],
                            ),
                          );
                        },
                      ),
                const SizedBox(height: 40),
                Text(
                  'My Celeb Requests',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                _RequestListWidget(),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RequestListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RequestsProvider>(context);
    final requests = provider.requests;
    final celebritiesList = provider.celebritiesList;
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 40),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: requests.length,
      itemBuilder: (BuildContext context, int index) {
        final request = requests[index];
        List storeCelebImage = celebritiesList
            .where((i) => i.name.contains(requests[index].celebrityName!))
            .toList();
        return GestureDetector(
          onTap: () {
            print('FanRequestsScreen: going to fanRequestDetailScreen');
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return MyCelebRequestDetailsScreen(
                request: request,
                celebrity: storeCelebImage[0],
              );
            }));
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: AssetImage(storeCelebImage[0].profileImage),
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
