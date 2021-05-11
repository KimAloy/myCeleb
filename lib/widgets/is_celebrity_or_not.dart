import 'package:flutter/material.dart';
import 'package:myceleb/model/model.dart';
import 'package:myceleb/screens/screens.dart';
import 'package:myceleb/widgets/widgets.dart';

class IsCelebrityOrNot extends StatefulWidget {
  final UserModel userModel;

  const IsCelebrityOrNot({Key? key, required this.userModel}) : super(key: key);

  @override
  _IsCelebrityOrNotState createState() => _IsCelebrityOrNotState();
}

class _IsCelebrityOrNotState extends State<IsCelebrityOrNot> {
  @override
  void initState() {
    super.initState();
    widget.userModel.isCelebrity
        ? Navigator.push(context, MaterialPageRoute(builder: (_) {
            return CelebrityAccountScreen();
          }))
        : Navigator.push(context, MaterialPageRoute(builder: (_) {
            return FanAccountScreen();
          }));
  }

  @override
  Widget build(BuildContext context) {
    return Loading();
  }
}
