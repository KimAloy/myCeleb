import 'package:flutter/material.dart';
import 'package:myceleb/model/model.dart';
import 'package:myceleb/provider/requests_provider.dart';
import 'package:myceleb/widgets/widgets.dart';
import 'package:provider/provider.dart';

class EditRequestScreen extends StatefulWidget {
  final Request request;
  final UserModel userModel;

  EditRequestScreen({
    Key? key,
    required this.request,
    required this.userModel,
  }) : super(key: key);

  @override
  _EditRequestScreenState createState() => _EditRequestScreenState();
}

class _EditRequestScreenState extends State<EditRequestScreen> {
  final _formKey = GlobalKey<FormState>();
  String? requestFromName;
  String? requestForName;
  String? message;
  String? requestDate;

  @override
  void initState() {
    super.initState();
    requestFromName = widget.request.requestFromName;
    requestForName = widget.request.requestForName;
    message = widget.request.message;
    requestDate = widget.request.requestDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                  'Edit Request',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                IconButton(
                  icon: Icon(Icons.close, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        UserCelebrityProfilePictureName(
                            celebrity: widget.userModel),
                        const SizedBox(height: 25),
                        buildText('REQUEST FROM NAME'),
                        MyTextFormField(
                          initialValue: requestFromName,
                          capitalization: TextCapitalization.words,
                          validator: (value) =>
                              value.isEmpty ? 'Please enter a Name' : null,
                          onChanged: (requestFromName) => setState(
                              () => this.requestFromName = requestFromName),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 25),
                        buildText('REQUEST FOR NAME'),
                        MyTextFormField(
                          initialValue: requestForName,
                          capitalization: TextCapitalization.words,
                          validator: (value) =>
                              value.isEmpty ? 'Please enter a Name' : null,
                          onChanged: (requestForName) => setState(
                              () => this.requestForName = requestForName),
                          maxLines: 1,
                        ),
                        const SizedBox(height: 25),
                        buildText('MESSAGE'),
                        MyTextFormField(
                          initialValue: message,
                          capitalization: TextCapitalization.sentences,
                          validator: (value) =>
                              value.isEmpty ? 'Please enter a Message' : null,
                          onChanged: (message) =>
                              setState(() => this.message = message),
                          maxLength: 250,
                          maxLines: null,
                          labelText: 'Max 250 characters',
                        ),
                        const SizedBox(height: 25),
                        buildText('REQUEST DATE'),
                        MyTextFormField(
                          initialValue: requestDate,
                          capitalization: TextCapitalization.none,
                          validator: (value) =>
                              value.isEmpty || value.length < 10
                                  ? 'Please enter a valid Date'
                                  : null,
                          onChanged: (requestDate) =>
                              setState(() => this.requestDate = requestDate),
                          keyboardType: TextInputType.number,
                          labelText: 'DD/MM/YYYY',
                          maxLines: 1,
                          inputFormatters: [
                            DateTextFormatter(),
                          ],
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: editRequest,
                          style:
                              ElevatedButton.styleFrom(primary: Colors.black),
                          child: Text(
                            'Save Changes',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 80),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Text buildText(String text) => Text(text);

  void editRequest() {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<RequestsProvider>(context, listen: false);
      provider.updateRequest(
          request: widget.request,
          requestFromName: requestFromName!,
          requestForName: requestForName!,
          message: message!,
          requestDate: requestDate!);
      print(
          'Save changes button pressed: EditRequestFormScreen\n Going back to FanRequestDetailsScreen');
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('Changes saved successfully!')));
    }
  }
}
