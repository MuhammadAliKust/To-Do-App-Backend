import 'package:b2_backend/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ForgotPasswordView extends StatefulWidget {
  ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  TextEditingController emailController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Reset Password View"),
        ),
        body: Column(
          children: [
            TextField(
              controller: emailController,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    isLoading = true;
                    setState(() {});
                    await AuthServices()
                        .forgotPassword(
                      emailController.text,
                    )
                        .then((val) {
                      isLoading = false;
                      setState(() {});

                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(
                                  "Email with password reset link has been sent to your mail box."),
                            );
                          });
                    });
                  } catch (e) {
                    isLoading = false;
                    setState(() {});
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                },
                child: Text("Send Link"))
          ],
        ),
      ),
    );
  }
}
