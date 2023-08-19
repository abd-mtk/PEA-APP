import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pea/Views/Constants/style.dart';

import '../../Models/event.dart';
import 'edit_bottom.dart';
import 'text_section.dart';

// ignore: must_be_immutable
class EventWidget extends StatefulWidget {
  Event? event;
  Function() onDeleted;
  Function() onEnable;
  Function() onEndevent;
  Function() onLocation;
  EventWidget({
    Key? key,
    this.event,
    required this.onDeleted,
    required this.onEnable,
    required this.onEndevent,
    required this.onLocation,
  }) : super(key: key);

  @override
  State<EventWidget> createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  showFlexibleBottomSheet(
                    minHeight: 0,
                    initHeight: 0.5,
                    maxHeight: 1,
                    context: context,
                    builder: (
                      BuildContext context,
                      ScrollController scrollController,
                      double bottomSheetOffset,
                    ) {
                      return Container(
                        decoration: snowContainer,
                        //add gridview here for the Four buttons
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 45.0, left: 15.0, right: 15.0),
                          child: GridView.count(
                            // stop scrolling
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            children: [
                              EditButton(
                                icon: const Icon(
                                  Icons.replay,
                                  color: Colors.green,
                                  size: 25,
                                ),
                                text: "تفعيل",
                                color: Colors.green,
                                onPressed: widget.onEnable,
                                backgroundColor: Colors.green[200],
                              ),
                              EditButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 25,
                                ),
                                text: "حذف",
                                color: Colors.red,
                                onPressed: widget.onDeleted,
                                backgroundColor: Colors.red[200],
                              ),
                              EditButton(
                                icon: const Icon(
                                  Icons.av_timer,
                                  color: Colors.blue,
                                  size: 25,
                                ),
                                text: "تمديد 24 ساعة",
                                color: Colors.blue,
                                onPressed: widget.onLocation,
                                backgroundColor: Colors.blue[200],
                              ),
                              EditButton(
                                icon: Icon(
                                  Icons.timer_off_outlined,
                                  color: Colors.indigo[700],
                                  size: 25,
                                ),
                                text: "إنهاء الحدث",
                                color: Colors.indigoAccent,
                                onPressed: widget.onEndevent,
                                backgroundColor: Colors.blue[200],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    anchors: [0, 0.5, 1],
                    isSafeArea: true,
                    bottomSheetColor: Colors.transparent,
                  );
                },
                icon: const Icon(Icons.dehaze_rounded)),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, left: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.event!.title == null || widget.event!.title!.isEmpty
                        ? 'لا يوجد عنوان'
                        : widget.event!.title!,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
        Image.network(widget.event!.image!,
            fit: BoxFit.cover, height: Get.height * 0.4),
        const Divider(
          color: Colors.grey,
          thickness: 0.5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.timer,
                color: widget.event!.endDate!.compareTo(DateTime.now()) < 0 ||
                        widget.event!.isEnded == true
                    ? Colors.red
                    : Colors.green,
                size: 30,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.event!.endDate!.compareTo(DateTime.now()) < 0 ||
                                widget.event!.isEnded == true
                            ? "منتهي"
                            : "مستمر",
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.event!.endDate!.toString().substring(0, 19),
                        textAlign: TextAlign.right,
                        style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2.0),
              child: IconButton(
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: Colors.blue, size: 25),
                  onPressed: () {
                    setState(() {
                      showDetails = !showDetails;
                    });
                  }),
            ),
          ],
        ),
        TextSection(
          text: widget.event!.description,
          lines: showDetails == true ? null : 2,
        ),
        Divider(
          color: Colors.grey[400],
          thickness: 1,
        ),
      ],
    );
  }
}
