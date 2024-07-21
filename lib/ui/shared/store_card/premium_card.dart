import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/button/fractionally_sized_box_button.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';

class PremiumCard extends StatefulWidget {
  final double topHeightSizedBox;
  final double bottomHeightSizedBox;
  final double containerHeight;
  final double containerWidth;
  final Alignment containerAlignment;
  final Color containerColor;

  const PremiumCard({
    super.key,
    this.topHeightSizedBox = 0.03,
    this.bottomHeightSizedBox = 0.03,
    this.containerHeight = 0.2,
    this.containerWidth = 0.85,
    this.containerAlignment = Alignment.center,
    this.containerColor = const Color.fromRGBO(21, 106, 142, 1),
  });

  @override
  State<PremiumCard> createState() => _PremiumCardState();
}

class _PremiumCardState extends State<PremiumCard> {
  late double _currentHeight;
  late double _currentWidth;
  late double _scaleFactor;

  @override
  void initState() {
    super.initState();
    _currentHeight = widget.containerHeight;
    _currentWidth = widget.containerWidth;
    _scaleFactor = 1.0;
  }

  void _shrinkContainer() {
    setState(() {
      _currentHeight = widget.containerHeight * 0.95;
      _currentWidth = widget.containerWidth * 0.95;
      _scaleFactor = 0.97;
    });
  }

  void _expandContainer() {
    setState(() {
      _currentHeight = widget.containerHeight;
      _currentWidth = widget.containerWidth;
      _scaleFactor = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.containerAlignment,
      child: Column(children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * widget.topHeightSizedBox,
        ),
        GestureDetector(
          onTapDown: (_) => _shrinkContainer(),
          onTapUp: (_) => _expandContainer(),
          onTapCancel: _expandContainer,
          child: AnimatedContainer(
            height: MediaQuery.of(context).size.height * _currentHeight,
            width: MediaQuery.of(context).size.width * _currentWidth,
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              color: widget.containerColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Transform.scale(
              scale: _scaleFactor,
              child: Column(
                children: [
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.0875,
                          left: MediaQuery.of(context).size.width * 0.0675),
                      child: Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: SizedBox(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.badge_outlined,
                                    size:
                                        MediaQuery.of(context).size.width * 0.2,
                                    color:
                                        const Color.fromRGBO(123, 198, 153, 1),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 2,
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    NormalText(
                                      text: "PREMIUM PASS",
                                      textStyle: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          color: Colors.white),
                                      alignment: Alignment.centerLeft,
                                    ),
                                    NormalText(
                                      text:
                                          "Get access to all the content and features purchasing the premium pass",
                                      textStyle: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.0325,
                                          color: Colors.white,
                                          height: 1.15),
                                      alignment: Alignment.centerLeft,
                                      textAlign: TextAlign.justify,
                                      maxLinesUnlimited: true,
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: SizedBox(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: FractionallySizedBox(
                          widthFactor: 0.8,
                          heightFactor: 0.7,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(123, 198, 153, 1),
                              borderRadius: BorderRadius.circular(7.5),
                            ),
                            child: const Center(
                                child: FractionallySizedBoxButton(
                              buttonText: "GET PREMIUM",
                              widthFactor: 1.3,
                            )),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height:
              MediaQuery.of(context).size.height * widget.bottomHeightSizedBox,
        ),
      ]),
    );
  }
}
