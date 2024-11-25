import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ows_bigcareer/view/wheel/wheel.dart';
import 'package:ows_bigcareer/view/wheel/wheel_side.dart';

class Wheel extends StatefulWidget {
  const Wheel({Key? key}) : super(key: key);

  @override
// ignore: library_private_types_in_public_api
  _WheelState createState() => _WheelState();
}

class _WheelState extends State<Wheel> {
  static int initialValue = 0;
  static int selectedItem = 1;
  FixedExtentScrollController controllerWC1 =
      FixedExtentScrollController(initialItem: initialValue);
  FixedExtentScrollController controllerWC2 =
      FixedExtentScrollController(initialItem: initialValue);
  FixedExtentScrollController controllerWC3 =
      FixedExtentScrollController(initialItem: initialValue);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                WheelChooserSide.integer(
                  onValueChanged: (s) => print(s.toString()),
                  controller: controllerWC3,
                  minValue: 0,
                  maxValue: 20,
                  isInfinite: true,
                  listHeight: 40,
                  listWidth: 40,
                  itemSize: 30,
                  squeeze: 0.75,
                  horizontal: false,
                  magnification: 2,
                  unSelectTextStyle: const TextStyle(color: Colors.grey),
                ),
                WheelChooser.integer(
                  onValueChanged: (s) => print(s.toString()),
                  controller: controllerWC3,
                  minValue: 0,
                  maxValue: 9,
                  isInfinite: true,
                  listHeight: 150,
                  listWidth: 83,
                  itemSize: 30,
                  squeeze: 0.75,
                  horizontal: false,
                  magnification: 2,
                  unSelectTextStyle: const TextStyle(color: Colors.grey),
                ),
                WheelChooser.integer(
                  onValueChanged: (s) => print(s.toString()),
                  controller: controllerWC3,
                  minValue: 0,
                  maxValue: 9,
                  isInfinite: true,
                  listHeight: 150,
                  listWidth: 83,
                  itemSize: 30,
                  squeeze: 0.75,
                  horizontal: false,
                  magnification: 2,
                  unSelectTextStyle: const TextStyle(color: Colors.grey),
                ),
                WheelChooser.integer(
                  onValueChanged: (s) => print(s.toString()),
                  controller: controllerWC3,
                  minValue: 0,
                  maxValue: 9,
                  isInfinite: true,
                  listHeight: 150,
                  listWidth: 83,
                  itemSize: 30,
                  squeeze: 0.75,
                  horizontal: false,
                  magnification: 2,
                  unSelectTextStyle: const TextStyle(color: Colors.grey),
                ),
                WheelChooserSide.integer(
                  onValueChanged: (s) => print(s.toString()),
                  controller: controllerWC3,
                  minValue: 0,
                  maxValue: 9,
                  isInfinite: true,
                  listHeight: 40,
                  listWidth: 40,
                  itemSize: 30,
                  squeeze: 0.75,
                  horizontal: false,
                  magnification: 2,
                  unSelectTextStyle: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: ElevatedButton(
                onPressed: () {
                  spinTO(3);
                },
                child: const Text('Spin')),
          ),
          ElevatedButton(
              onPressed: () {
                resetWheel(0);
              },
              child: const Text('Spin')),
        ],
      ),
    );
  }

  spinTO(int value){
    controllerWC1!.animateToItem(value,
        duration: const Duration(seconds: 1), curve: const SawTooth(5));
    Future.delayed(const Duration(seconds: 1), () {
      controllerWC1?.jumpToItem(value.toInt());
    });
    controllerWC2!.animateToItem(value,
        duration: const Duration(seconds: 2), curve: const SawTooth(5));
    Future.delayed(const Duration(seconds: 2), () {
      controllerWC2?.jumpToItem(value.toInt());
    });
    controllerWC3!.animateToItem(2,
        duration: const Duration(seconds: 3), curve: const SawTooth(5));
    Future.delayed(const Duration(seconds: 3), () {
      controllerWC3?.jumpToItem(value.toInt());
    });
  }
  incrementNumber(int value) {
    print('-------------${controllerWC1!.selectedItem}');
    controllerWC1!.animateTo(2,
        duration: const Duration(seconds: 2), curve: const SawTooth(5));
    controllerWC2!.animateTo(2,
        duration: const Duration(seconds: 2), curve: const SawTooth(5));
    controllerWC3!.animateTo(2,
        duration: const Duration(seconds: 2), curve: const SawTooth(5));
    print('-------------${controllerWC1!.selectedItem}');
    Future.delayed(const Duration(seconds: 2), () {
      controllerWC1?.jumpToItem(1);
      controllerWC2?.jumpToItem(2);
      controllerWC3?.jumpToItem(5);
    });
    print('-------------${controllerWC1!.selectedItem}');
    print('-------------${controllerWC1!.selectedItem}');
  }

  resetWheel(int value) {
    controllerWC1?.jumpToItem(value);
    controllerWC2?.jumpToItem(value);
    controllerWC3?.jumpToItem(value);
  }
}

class WheelAnimation extends StatelessWidget {
  const WheelAnimation({Key? key, required this.controllerWC})
      : super(key: key);
  final FixedExtentScrollController? controllerWC;

  @override
  Widget build(BuildContext context) {
    return WheelChooser.integer(
      onValueChanged: (s) => print(s.toString()),
      controller: controllerWC,
      minValue: 0,
      maxValue: 20,
      isInfinite: true,
      listHeight: 150,
      listWidth: 100,
      itemSize: 30,
      squeeze: 0.75,
      horizontal: false,
      magnification: 2,
      unSelectTextStyle: const TextStyle(color: Colors.grey),
    );
  }
}
