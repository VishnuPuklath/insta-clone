import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insta_clone/utils/color.dart';
import 'package:insta_clone/widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          //image insta
          SvgPicture.asset(
            'assets/ic_instagram.svg',
            color: primaryColor,
            height: 64,
          ),
          Stack(children: [
            CircleAvatar(
              radius: 64,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1655321375577-45968768ff32?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHw1fHx8ZW58MHx8fHw%3D&auto=format&fit=crop&w=500&q=60'),
            ),
            Positioned(
                bottom: -10,
                left: 80,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add_a_photo),
                ))
          ]),
          const SizedBox(
            height: 24,
          ),
          //textfield for email
          TextFieldInput(
              hintText: 'Enter your username',
              textEditingController: _usernameController,
              textInputType: TextInputType.text),
          const SizedBox(
            height: 24,
          ),
          TextFieldInput(
              hintText: 'Enter your Email Address',
              textEditingController: _emailController,
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 24,
          ),
          TextFieldInput(
            hintText: 'Enter your Password',
            textEditingController: _passwordController,
            textInputType: TextInputType.text,
            isPass: true,
          ),
          const SizedBox(
            height: 24,
          ),
          TextFieldInput(
              hintText: 'Enter your bio',
              textEditingController: _bioController,
              textInputType: TextInputType.text),
          GestureDetector(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: ShapeDecoration(
                  color: blueColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)))),
              child: Text('Sign up'),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Flexible(
            child: Container(),
            flex: 2,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Container(
          //       padding: EdgeInsets.symmetric(vertical: 8),
          //       child: Text('Don\'t have an account?'),
          //     ),
          //     Container(
          //       padding: EdgeInsets.symmetric(vertical: 8),
          //       child: Text(
          //         'Sign up.',
          //         style: TextStyle(fontWeight: FontWeight.bold),
          //       ),
          //     ),
          //   ],
          // )
          //textfield for password
          //login button
          //transistion
        ]),
      ),
    ));
  }
}
