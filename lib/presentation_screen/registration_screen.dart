import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_db/bussiness_logic/inser_db_bloc/insert_db_bloc.dart';
import 'package:firebase_db/bussiness_logic/inser_db_bloc/insert_db_event.dart';
import 'package:firebase_db/presentation_screen/user_screen.dart';
import 'package:firebase_db/utils/data_sync_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/connectivity_service.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return RegistrationScreenWidget();
  }
}

class RegistrationScreenWidget extends State<RegistrationScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    ConnectivityService()
        .listenToConnectionChanges((ConnectivityResult result) {
      syncDbData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.height * 0.1,
            ),
            Center(
              child: Hero(
                tag: "splashTag",
                child: SizedBox(
                    width: size.width * 0.4,
                    height: size.height * 0.1,
                    child: Image.asset("assets/images/dolphin_image.png")),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.09),
              child: Text(
                "Sign Up",
                style: TextStyle(
                    fontSize: size.height * 0.03, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.09, top: size.width * 0.02),
              child: const Text(
                "Enter your Information Below",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Material(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    left: size.width * 0.07, right: size.width * 0.07),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Theme.of(context).primaryColor)),
                child: SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.06,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme:
                          ColorScheme.fromSwatch(primarySwatch: Colors.cyan),
                      primaryColor: Colors
                          .red, // Change the primary color for this text field
                    ),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      controller: firstNameController,
                      decoration: const InputDecoration(
                          hintText: "First Name",
                          hintStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w300),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            left: 15,
                            right: 10,
                            top: 0,
                          )),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Material(
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    left: size.width * 0.07, right: size.width * 0.07),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Theme.of(context).primaryColor)),
                child: SizedBox(
                  width: size.width * 0.9,
                  height: size.height * 0.06,
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme:
                          ColorScheme.fromSwatch(primarySwatch: Colors.cyan),
                      primaryColor: Colors
                          .red, // Change the primary color for this text field
                    ),
                    child: TextFormField(
                      controller: lastNameController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                          hintText: "Last Name",
                          hintStyle: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w300),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                            left: 15,
                            right: 10,
                            top: 0,
                          )),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.07,
            ),
            GestureDetector(
              onTap: () async {
                if (firstNameController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Please Enter Valid First Name");
                  return;
                }
                if (lastNameController.text.isEmpty) {
                  Fluttertoast.showToast(msg: "Please Enter Valid Last Name");
                  return;
                }
                context.read<InsertDbBloc>().add(InsertDbEvent(
                    userId: "",
                    lastName: lastNameController.text,
                    firstName: firstNameController.text,
                    status: ""));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserScreen()));
              },
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  width: size.width * 0.4,
                  height: size.height * 0.06,
                  margin: EdgeInsets.only(
                      left: size.width * 0.07, right: size.width * 0.07),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Sign Up",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: size.height * 0.025))
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
