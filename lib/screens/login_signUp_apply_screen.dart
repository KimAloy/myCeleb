import 'package:flutter/material.dart';
import 'package:myceleb/model/model.dart';
import 'package:myceleb/screens/screens.dart';
import 'package:myceleb/widgets/widgets.dart';

class LoginSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: kLightGreen,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enroll as talent',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: MyTextAnimation(),
                ),
                const SizedBox(height: 8),
                _LoginSignUpTextFormField(
                  obscureText: false,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email,
                  labelText: 'Email',
                  validator: (val) =>
                      val.isEmpty ? 'Enter a valid email' : null,
                ),
                _LoginSignUpTextFormField(
                  obscureText: true,
                  prefixIcon: Icons.lock,
                  labelText: 'Password',
                  validator: (val) => val.isEmpty ? 'Enter a password' : null,
                ),
                // const SizedBox(height: 4),
                Row(
                  children: [
                    Spacer(),
                    GestureDetector(
                      child: TextButton(
                        onPressed: () {
                          print('Forgot password pressed');
                        },
                        child: Text('Forgot password'),
                        style: TextButton.styleFrom(primary: Colors.black),
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 4),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Implement isCelerityOrNot below
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            // IsCelebrityOrNot()
                            FanAccountScreen()));
                    print('Login button pressed: Going to my account screen');
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.black),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    // TODO: Go to my account screen

                    // Navigator.of(context).push(MaterialPageRoute(
                    //     builder: (context) =>
                    //         RequestFormScreen(celebrity: celebrity)));
                    print('Sign up button pressed: Going to my account screen');
                  },
                  style: ElevatedButton.styleFrom(primary: kLightGreen),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      primary: Colors.green, side: BorderSide(width: 1)),
                  child: Text('Enroll as talent',
                      style: TextStyle(color: Colors.black)),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ApplyToJoinCeleeb();
                    }));
                    print('Enroll as talent pressed');
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginSignUpTextFormField extends StatelessWidget {
  final validator;
  final controller;
  final labelText;
  final inputFormatters;
  final TextInputType? keyboardType;
  final String? initialValue;
  final IconData? prefixIcon;
  final bool obscureText;

  const _LoginSignUpTextFormField({
    Key? key,
    this.validator,
    this.controller,
    this.labelText,
    this.inputFormatters,
    this.keyboardType,
    this.initialValue,
    this.prefixIcon,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      cursorColor: Colors.black,
      style: TextStyle(fontSize: 15),
      decoration: InputDecoration(
        prefix: Icon(prefixIcon),
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
