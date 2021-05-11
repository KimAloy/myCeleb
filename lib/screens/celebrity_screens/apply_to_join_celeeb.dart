import 'package:flutter/material.dart';
import 'package:myceleb/screens/screens.dart';
import 'package:myceleb/widgets/widgets.dart';

class ApplyToJoinCeleeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  'Apply to join as talent!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                Center(child: MyTextAnimation()),
                const SizedBox(height: 15),

                Text(
                  'If you have a fanbase and want to join Celeeb as talent, you can apply here and we\'ll be in touch within 72 hours.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                ApplyToJoinTextFormField(
                  maxLines: 1,
                  showPrefixIcon: false,
                  labelText: 'Name',
                  validator: (val) => val.isEmpty ? 'Enter a name' : null,
                ),
                const SizedBox(height: 10),
                ApplyToJoinTextFormField(
                  maxLines: 1,
                  showPrefixIcon: true,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  validator: (val) =>
                      val.isEmpty ? 'Enter a valid email' : null,
                ),
                const SizedBox(height: 10),
                ApplyToJoinTextFormField(
                  maxLines: 1,
                  showPrefixIcon: true,
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icon(Icons.phone),
                  labelText: 'Phone number (never shared)*',
                  validator: (val) =>
                      val.isEmpty ? 'Enter a phone number' : null,
                ),
                const SizedBox(height: 30),
                Text('Where can we find you?*'),
                const SizedBox(height: 8),
                WhereCanWeFindYouDialogButton(),
                const SizedBox(height: 30),
                Text('Your handle*'),
                // const SizedBox(height: 4),
                ApplyToJoinTextFormField(
                  maxLines: 1,
                  showPrefixIcon: false,
                  labelText: '@buchana',
                  validator: (val) => val.isEmpty ? 'Enter your handle' : null,
                ),
                const SizedBox(height: 10),
                ApplyToJoinTextFormField(
                  maxLines: 1,
                  showPrefixIcon: false,
                  labelText: 'How many followers do you have?*',
                  validator: (val) =>
                      val.isEmpty ? 'Enter your number of followers' : null,
                ),
                const SizedBox(height: 30),
                // Text('Anything else we should know about you'),

                // ApplyToJoinTextFormField(
                //   maxLength: 300,
                //   maxLines: null,
                //   showPrefixIcon: false,
                // ),
                // const SizedBox(height: 30),
                Text(
                  'Note: you are not automatically enrolled on Celeeb. If you meet the eligibility requirements, a talent representative will contact you within a few days to finish onboarding.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () {
                    // TODO: add request to firestore admin database
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return CelebrityAccountScreen();
                    }));

                    /// Code below pops until celebritiesScreen
                    // Navigator.of(context).pushAndRemoveUntil(
                    //     MaterialPageRoute(
                    //     builder: (context) => CelebritiesScreen()),
                    //     (Route<dynamic> route) => false);
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(SnackBar(
                          content:
                              Text('Application successfully submitted!')));

                    print('Apply to join button pressed: Going to nav screen');
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: Text(
                    'Submit',
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

class ApplyToJoinTextFormField extends StatelessWidget {
  final validator;
  final controller;
  final labelText;
  final inputFormatters;
  final TextInputType? keyboardType;
  final String? initialValue;
  final prefixIcon;
  final bool showPrefixIcon;
  final maxLines;
  final maxLength;

  const ApplyToJoinTextFormField({
    Key? key,
    this.validator,
    this.controller,
    this.labelText,
    this.inputFormatters,
    this.keyboardType,
    this.initialValue,
    this.prefixIcon,
    required this.showPrefixIcon,
    this.maxLines,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      cursorColor: Colors.black,
      style: TextStyle(fontSize: 15),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(5, 20, 5, 2),
        prefix: showPrefixIcon ? prefixIcon : null,
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.black54),
        isDense: true,
        focusColor: Colors.black,
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
      inputFormatters: inputFormatters,
    );
  }
}
