import 'dart:ui';

import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    this.colorDrop,
    required this.constraints,
    required this.child,
    required this.onSelected,
    required this.items,
    required this.widthDropItem,
  });
  final Widget child;
  final Color? colorDrop;
  final Function onSelected;
  final List<CustomDropModel> items;
  final BoxConstraints constraints;
  final double widthDropItem;

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  GlobalKey? actionKey;
  bool isDropdownOpened = false;
  OverlayEntry? floatingDropdown;
  double? xPosition;
  double? yPosition;
  Size? size;
  Size? sizeScaffold;

  @override
  void initState() {
    actionKey = LabeledGlobalKey('myKey');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.sizeScaffold = MediaQuery.of(context).size;
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isDropdownOpened) {
            floatingDropdown!.remove();
          } else {
            findDropdownData();
            floatingDropdown = _createFloatingDropdown();
            Overlay.of(context)!.insert(floatingDropdown!);
          }
          isDropdownOpened = !isDropdownOpened;
        });
      },
      child: widget.child,
    );
  }

  void findDropdownData() {
    RenderBox? renderBox =
        actionKey!.currentContext!.findAncestorRenderObjectOfType();

    this.size = renderBox!.size;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createFloatingDropdown() {
    // print(this.sizeScaffold.width);
    // print(widget.widthDropItem);
    // print(this.size.width);
    // print(xPosition);
    // print(widget.widthDropItem -
    //     (widget.widthDropItem - this.sizeScaffold.width) -
    //     xPosition);
    // print('===');
    // print(widget.widthDropItem + xPosition);
    // print(this.sizeScaffold.width);
    return OverlayEntry(
      builder: (context) {
        return Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: () {
                floatingDropdown!.remove();
                isDropdownOpened = !isDropdownOpened;
                setState(() {});
              },
            ),
            Positioned(
              left: (widget.widthDropItem + xPosition!) <=
                      this.sizeScaffold!.width
                  ? xPosition
                  : (xPosition! + this.size!.width) - widget.widthDropItem,
              width: widget.widthDropItem,
              // widget.widthDropItem == null
              //     ? this.size.width
              //     : widget.widthDropItem,
              // // (widget.widthDropItem + xPosition) <= this.sizeScaffold.width
              //     ? xPosition
              //     : widget.widthDropItem -
              //         (widget.widthDropItem - this.sizeScaffold.width),
              top: (this.sizeScaffold!.height - yPosition!) >=
                      widget.constraints.maxHeight
                  ? yPosition! + this.size!.height
                  : yPosition! - widget.constraints.maxHeight,
              child: Material(
                elevation: 4,
                child: Container(
                  // color: Colors.red[100],
                  constraints: widget.constraints,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (var item in widget.items)
                          InkWell(
                            onTap: () {
                              floatingDropdown!.remove();
                              isDropdownOpened = !isDropdownOpened;
                              setState(() {});
                              widget.onSelected(item);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  item.icon != null
                                      ? Icon(item.icon, color: Colors.grey)
                                      : SizedBox(),
                                  SizedBox(width: 10),
                                  Flexible(
                                    child: Text(
                                      item.label,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class CustomDropModel {
  CustomDropModel({
    required this.label,
    required this.value,
    this.icon,
  });

  String label;
  dynamic value;
  IconData? icon;

  factory CustomDropModel.fromJson(Map<String, dynamic> json) =>
      CustomDropModel(
        label: json["label"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };
}
