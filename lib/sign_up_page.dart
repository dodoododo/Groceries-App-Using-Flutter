import 'package:flutter/material.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  String password = "";
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(width: double.infinity),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [
              Colors.pink.withValues(alpha: 0.2),
              Colors.white.withValues(alpha: 0.3),
              Colors.white.withValues(alpha: 0.3),
              Colors.white.withValues(alpha: 0.3),
            ],
          ),
        ),
        child: Column(

        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 70,
            height: 70,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Image.asset("assets/images/group.png"),
          ),

          Container(
            width: 370,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text (
                      "Sign Up",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30, fontFamily: 'Roboto'),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text (
                      "Enter your credentials to continue",
                      style: TextStyle(color: Colors.grey, fontSize: 15, fontFamily: 'Roboto'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),


          SizedBox(              
            width: 370,
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "First Name",
                  style: TextStyle(color: const Color.fromARGB(255, 161, 156, 156), fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
          Padding( //password
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              width: 370,
              height: 50,
              child: TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w200, wordSpacing: 7),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),

          SizedBox(              
            width: 370,
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Last Name",
                  style: TextStyle(color: const Color.fromARGB(255, 161, 156, 156), fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
          Padding( //password
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              width: 370,
              height: 50,
              child: TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w200, wordSpacing: 7),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),


          SizedBox(              
            width: 370,
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Username",
                  style: TextStyle(color: const Color.fromARGB(255, 161, 156, 156), fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
          Padding( //password
            padding: const EdgeInsets.all(5),
            child: SizedBox(
              width: 370,
              height: 50,
              child: TextFormField(
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w200, wordSpacing: 7),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),


          SizedBox(              
            width: 370,
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: TextStyle(color: const Color.fromARGB(255, 161, 156, 156), fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
            buildEmailInput(),
          SizedBox(
            height: 5,
          ),

          SizedBox(              
            width: 370,
            height: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Password",
                  style: TextStyle(color: const Color.fromARGB(255, 161, 156, 156), fontSize: 16, fontWeight: FontWeight.w600, fontFamily: 'Roboto'),
                ),
              ],
            ),
          ),
          buildPassword(),

            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 370,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text.rich(
                      TextSpan(
                        text: 'By continuing, you agree to our ',
                        style: const TextStyle(
                          color: Color(0xFFA19C9C),
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Roboto',
                        ),
                        children: const [
                          TextSpan(
                            text: 'Terms Of Service',
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                          ),
                          TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(color: Colors.green, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),


            buildSignupButton(),

            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Already Have An Account? ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],

            ),
          ],
        ),
      ),
    );
  }
  Widget buildEmailInput() => Padding( //username
    padding: const EdgeInsets.all(1),
    child: SizedBox(
      width: 370,
      height: 50,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please input Email";
          }
          final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
          if (!emailRegex.hasMatch(value)) {
            return "Enter a valid email";
          }
          return null;
        },

        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w200, wordSpacing: 7),
      ),
    ),
  );

  Widget buildPassword() => Padding( //password
    padding: const EdgeInsets.all(5),
    child: SizedBox(
      width: 370,
      height: 50,
      child: TextFormField(
        onChanged: (value) => setState(() {
          password = value;
        }),
        onFieldSubmitted: (value) => setState(() {
          password = value;
        }),
        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w200, wordSpacing: 7),
        decoration: InputDecoration(
          suffixIcon: Container(
            margin: EdgeInsets.only(
              right: 3,
            ),
            child: IconButton(icon:
            isPasswordVisible ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
                onPressed: () => {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  }),
                }
            ),
          ),
        ),
        obscureText: isPasswordVisible,
      ),
    ),
  );

  Widget buildSignupButton() => ElevatedButton(
    style: ElevatedButton.styleFrom(
      fixedSize: Size(370, 55),
      backgroundColor: Colors.green,   // button color
      foregroundColor: Colors.white,  // text color
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => (LoginPage())),
      );
    },
    child: Text("Sign Up", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, fontFamily: 'Roboto')),
  );
}