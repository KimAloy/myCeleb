import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myceleb/model/model.dart';
import 'package:myceleb/provider/provider.dart';
import 'package:myceleb/screens/screens.dart';
import 'package:myceleb/widgets/widgets.dart';
import 'package:provider/provider.dart';

class MakeRequestScreen extends StatefulWidget {
  final UserModel celebrity;
  final UserModel fan;

  const MakeRequestScreen(
      {Key? key, required this.fan, required this.celebrity})
      : super(key: key);

  @override
  _MakeRequestScreenState createState() => _MakeRequestScreenState();
}

class _MakeRequestScreenState extends State<MakeRequestScreen> {
  initState() {
    super.initState();
    requestFromController.text = widget.fan.name;
  }

  final _formKey = GlobalKey<FormState>();
  final requestFromController = TextEditingController();
  final requestForController = TextEditingController();
  final messageController = TextEditingController();
  final _requestDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Cancel'),
                  ),
                  Text(
                    'Make Request',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      UserCelebrityProfilePictureName(
                          celebrity: widget.celebrity),
                      const SizedBox(height: 25),
                      buildText('REQUEST FROM NAME'),
                      MyTextFormField(
                        capitalization: TextCapitalization.words,
                        validator: (value) =>
                            value.isEmpty ? 'Please enter a Name' : null,
                        controller: requestFromController,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 25),
                      buildText('REQUEST FOR NAME'),
                      MyTextFormField(
                        capitalization: TextCapitalization.words,
                        validator: (value) =>
                            value.isEmpty ? 'Please enter a Name' : null,
                        controller: requestForController,
                        maxLines: 1,
                      ),
                      const SizedBox(height: 25),
                      buildText('MESSAGE'),
                      MyTextFormField(
                        capitalization: TextCapitalization.sentences,
                        validator: (value) =>
                            value.isEmpty ? 'Please enter a Message' : null,
                        controller: messageController,
                        maxLength: 250,
                        maxLines: null,
                        labelText: 'Max 250 characters',
                      ),
                      const SizedBox(height: 25),
                      buildText('REQUEST DATE'),
                      MyTextFormField(
                        capitalization: TextCapitalization.none,
                        validator: (value) => value.isEmpty || value.length < 10
                            ? 'Please enter a valid Date'
                            : null,
                        controller: _requestDateController,
                        keyboardType: TextInputType.number,
                        labelText: 'DD/MM/YYYY',
                        maxLines: 1,
                        inputFormatters: [
                          DateTextFormatter(),
                        ],
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: buy,
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        child: Text(
                          'Buy',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Text buildText(String text) => Text(text, style: kTitleTextStyle);
  void buy() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      // TODO: show dialog for initiating MTN, Airtel payments
      final request = Request(
        id: DateTime.now().toString(),
        createdTime: DateTime.now(),
        celebrityName: widget.celebrity.name,
        requestFromName: requestFromController.text,
        requestForName: requestForController.text,
        message: messageController.text,
        requestDate: _requestDateController.text,
        requesterProfilePicture: widget.fan.profileImage!,
        fanEmail: widget.fan.email!,
      );
      final provider = Provider.of<RequestsProvider>(context, listen: false);
      provider.addRequest(request);
      Navigator.pop(context);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => FanAccountScreen()));

      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Request sent successfully!')));
      print('Buy button pressed: stream that adds to MyCelebRequestScreen');
    }
  }
}
