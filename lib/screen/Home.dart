import 'dart:ffi';

import 'package:clipboard/clipboard.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instadl/model/Request.dart';
import 'package:instadl/model/mixed.dart';
import 'package:instadl/components/Tab.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:flutter/material.dart';
import '../service/locator.dart';
import '../components/btn.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final MixedClass mixedClass = sl.get<MixedClass>();
  final RequestDio requestDio = sl.get<RequestDio>();
  bool error = false;
  String errorText = "";
  @override
  void initState() {
    super.initState();
    mixedClass.checkPermission();
    // mixedClass.createFolder();
  }

  final TextEditingController inputController = TextEditingController();

//create inputcontroller
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          // Divider(),
          const Tabs(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 1,
              onChanged: (e) {},
              controller: inputController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: BorderSide(width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orangeAccent),
                ),
                disabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                contentPadding: EdgeInsets.all(10.0),
                hintText: 'Paste Instagram Link Here',
                // helperText: 'Keep it short, this is just a demo.',
                // labelText: 'Life story',
                // prefixIcon: const Icon(
                //   Icons.person,
                //   color: Colors.green,
                // ),
                // // prefixText: ' ',
                // suffixText: 'USD',
                suffixStyle: const TextStyle(color: Colors.green),
              ),
            ),
          ),
          // EmailInputFb1(inputController: inputController),
          (error
              ? Text(
                  errorText,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                )
              : Container()),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: GradientButtonFb4(
                  onPressed: () {
                    FlutterClipboard.paste().then((value) {
                      // Do what ever you want with the value.
                      setState(() {
                        inputController.text = value;
                        inputController.selection = TextSelection.fromPosition(
                            TextPosition(offset: inputController.text.length));
                      });
                    });
                    requestDio.allinone(inputController.text);
                  },
                  text: "Paste Link",
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GradientButtonFb4(
                  onPressed: () {
                    if (!inputController.text
                        .contains("https://www.instagram.com/")) {
                      Fluttertoast.showToast(
                          msg: "Please Enter Valid Instagram Url");
                      setState(() {
                        error = true;
                        errorText = "Please Enter Instagram URL";
                      });
                    } else {
                      setState(() {
                        error = false;
                      });
                    }
                  },
                  text: "Download".toUpperCase(),
                ),
              ),
              const SizedBox(width: 10),
            ],
          )
        ],
      ),
    );
  }
}

class GradientButtonFb4 extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const GradientButtonFb4(
      {required this.text, required this.onPressed, Key? key})
      : super(key: key);

  final double borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    return
        // DecoratedBox(
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(borderRadius),
        //         gradient: const LinearGradient(colors: [
        //           Color.fromRGBO(0, 116, 224, 0.957),
        //           Color(0xFF0856FF)
        //         ])),
        //     child:
        ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                alignment: Alignment.center,
                padding: MaterialStateProperty.all(const EdgeInsets.only(
                  right: 25,
                  left: 25,
                )),
                backgroundColor: MaterialStateProperty.all(Colors.grey[300]),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius)),
                )),
            onPressed: onPressed,
            child: Text(
              text.toUpperCase(),
              style: const TextStyle(color: Colors.black54),
            ));
    // );
  }
}
