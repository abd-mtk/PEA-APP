import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TimeWidget extends StatelessWidget {
  DateTime? time;
  TimeWidget({
    Key? key,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        time == null ? timeView(DateTime.now()) : timeView(time!),
      ],
    );
  }

  Container timeView(DateTime time) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
        ),
        color: Colors.grey[300],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "${time.year}-${time.month}-${time.day} ${time.hour}:${time.minute}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
