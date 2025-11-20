import 'package:flutter/material.dart';
import 'package:liviapos/helper/alertdialog_helper.dart';
import 'package:liviapos/helper/display_helper.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DisplayHelper display = DisplayHelper();

    UserProvider userProv = Provider.of<UserProvider>(context, listen: false);

    userProv.setObsecure = true;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('LIVIA POS'),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: display.widthDp(context),
          height: display.heightDp(context),
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  controller: userProv.cUsername,
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    hintText: 'example',
                    hintStyle: TextStyle(color: Colors.black26),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Consumer<UserProvider>(
                builder: (context, prov, child) {
                  return SizedBox(
                    width: 300,
                    child: TextField(
                      controller: userProv.cPassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.remove_red_eye_outlined),
                          onPressed: () {
                            prov.changeVisiblePassword();
                          },
                        ),
                      ),
                      obscureText: prov.obsecure,
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  userProv.currentUser.clear();
                  userProv.getCurrentUser();
                  userProv.cekLogin().then(
                    (value) {
                      if (context.mounted) {
                        if (userProv.message.contains('salah')) {
                          debugPrint(userProv.message);
                          AlertdialogHelper.showSimpleAlertDialog(context,
                              title: 'Peringatan!', message: userProv.message);
                        }
                        if (userProv.message.contains('berhasil')) {
                          Navigator.pushReplacementNamed(
                            context,
                            '/main',
                          );
                        }
                      }
                    },
                  );
                },
                child: const Text('Login'),
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'olizyusuf.my.id',
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '@2025',
                    style:
                        TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
