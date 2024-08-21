import 'package:b2_backend/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  TextEditingController emailController = TextEditingController();

  TextEditingController pwdController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Register View"),
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
                        .signUp(
                            email: emailController.text,
                            password: pwdController.text)
                        .then((val) {
                      isLoading = false;
                      setState(() {});
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text("Registerd"),
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
                child: Text("Register"))
          ],
        ),
      ),
    );
  }
}
