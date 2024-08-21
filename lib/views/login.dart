import 'package:b2_backend/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController pwdController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login View"),
        ),
        body: Column(
          children: [
            TextField(
              controller: emailController,
            ),
            TextField(
              controller: pwdController,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    isLoading = true;
                    setState(() {});
                    await AuthServices()
                        .login(
                            email: emailController.text,
                            password: pwdController.text)
                        .then((val) {
                      isLoading = false;
                      setState(() {});
                      if(val!.emailVerified == false){
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("Kindly verify your email"),
                              );
                            });
                      }
                    else{
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Text("Logged In"),
                              );
                            });
                      }
                    });
                  } catch (e) {
                    isLoading = false;
                    setState(() {});
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: Text("Login"))
          ],
        ),
      ),
    );
  }
}
