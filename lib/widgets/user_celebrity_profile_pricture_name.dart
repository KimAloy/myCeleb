import 'package:flutter/material.dart';
import 'package:myceleb/model/model.dart';
import 'package:myceleb/provider/provider.dart';
import 'package:provider/provider.dart';

class UserCelebrityProfilePictureName extends StatelessWidget {
  final UserModel celebrity;
  // final UserModel? fan;

  const UserCelebrityProfilePictureName({
    Key? key,
    // this.fan,
    required this.celebrity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RequestsProvider>(context);
    final fan = provider.getCurrentFan;
    return Column(
      children: [
        Row(
          children: [
            fan.profileImage == null
                ? CircleAvatar(
                    child: Text(
                      '${fan.name[0]}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.black38,
                  )
                : CircleAvatar(
                    backgroundImage: AssetImage(fan.profileImage!),
                    backgroundColor: Colors.transparent,
                  ),
            const SizedBox(width: 5),
            Text(
              fan.name,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        Row(
          children: [
            Spacer(),
            Text(
              celebrity.name,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 5),
            CircleAvatar(
              backgroundImage: AssetImage(celebrity.profileImage!),
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
      ],
    );
  }
}
