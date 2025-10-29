import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../login/login_page.dart';
import 'sign_up_cubit.dart';
import 'sign_up_state.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: BlocListener<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state.isSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Đăng ký thành công! Vui lòng đăng nhập.'),
                  backgroundColor: Colors.green,
                ),
              );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          }
          
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: Colors.red,
                ),
              );
          }
        },
        child: const _SignUpView(),
      ),
    );
  }
}

class _SignUpView extends StatelessWidget {
  const _SignUpView({super.key});

  Widget labelText(String text) => SizedBox(
    width: 370,
    height: 20,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Color.fromARGB(255, 161, 156, 156),
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();

    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(width: double.infinity),
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          child: BlocBuilder<SignUpCubit, SignUpState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Colors.green),
                      SizedBox(height: 20),
                    ],
                  ),
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(shape: BoxShape.circle),
                    child: Image.asset("assets/images/group.png"),
                  ),
                  Container(
                    width: 370,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            fontFamily: 'Roboto',
                          ),
                        ),
                        Text(
                          "Enter your credentials to continue",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  labelText("First Name"),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      width: 370,
                      height: 50,
                      child: TextFormField(
                        onChanged: cubit.firstNameChanged,  
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          wordSpacing: 7,
                        ),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 5),

                  labelText("Last Name"),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      width: 370,
                      height: 50,
                      child: TextFormField(
                        onChanged: cubit.lastNameChanged,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          wordSpacing: 7,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  labelText("Username"),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      width: 370,
                      height: 50,
                      child: TextFormField(
                        onChanged: cubit.usernameChanged, 
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          wordSpacing: 7,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  labelText("Email"),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      width: 370,
                      height: 70,
                      child: TextField(
                        onChanged: cubit.emailChanged,
                        decoration: InputDecoration(
                          errorText: state.emailError,
                          errorStyle: const TextStyle(color: Colors.red),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          wordSpacing: 7,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 5),

                  labelText("Password"),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: SizedBox(
                      width: 370,
                      height: 70,
                      child: TextField(
                        onChanged: cubit.passwordChanged,
                        obscureText: !state.isPasswordVisible,
                        decoration: InputDecoration(
                          errorText: state.passwordError,
                          errorStyle: const TextStyle(color: Colors.red),
                          suffixIcon: IconButton(
                            icon: Icon(
                              state.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: cubit.togglePasswordVisibility,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                          wordSpacing: 7,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

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
                              children: [
                                TextSpan(
                                  text: 'Terms Of Service',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(370, 55),
                      backgroundColor: state.isFormValid
                          ? Colors.green
                          : Colors.grey,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: state.isFormValid ? () => cubit.signUp() : null,
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
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
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: const Text(
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
              );
            },
          ),
        ),
      ),
    );
  }
}