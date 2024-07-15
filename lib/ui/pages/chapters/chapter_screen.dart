import 'package:flutter/material.dart';
import 'package:langspeak/domain/models/chapter_content_model/chapter_content_model.dart';
import 'package:langspeak/ui/shared/app_bar/normal_app_bar.dart';
import 'package:langspeak/ui/shared/button/normal_button.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({super.key, this.content});

  final ChapterUserContent? content;

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  late int _pages = widget.content?.content.length ?? 1;
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NormalAppBar(),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(21, 106, 142, 1),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: const Color.fromRGBO(12, 78, 107, 1),
                      width: MediaQuery.of(context).size.width * 0.125,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Text(
                        "S${widget.content?.season}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        // color: Color.fromARGB(255, 90, 167, 200),
                        width: MediaQuery.of(context).size.width * 0.675,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(21, 106, 142, 1),
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(5),
                              topRight: Radius.circular(5)),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: NormalText(
                                text: widget.content?.seasonName ?? "",
                                alignment: Alignment.bottomLeft,
                                textStyle: const TextStyle(
                                    color: Colors.white, fontSize: 15),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 12),
                              ),
                            ),
                            Expanded(
                                child: NormalText(
                              text: widget.content?.chapterName ?? "",
                              alignment: Alignment.topLeft,
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 11.5,
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 12),
                            )),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.625,
            color: const Color.fromRGBO(21, 106, 142, 1),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.07,
                  color: const Color.fromRGBO(12, 78, 107, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: NormalText(
                          text: widget.content?.motto.toUpperCase() ??
                              "MOTTO NOT RECOGNIZED",
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          textAlign: TextAlign.justify,
                          alignment: Alignment.bottomLeft,
                        ),
                      ),
                      Expanded(
                        child: NormalText(
                          text: "PART $_currentPage / $_pages",
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          textAlign: TextAlign.justify,
                          alignment: Alignment.topLeft,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.555,
                  // color: Colors.red,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "$_currentPage) ${widget.content?.content[_currentPage - 1].title}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 13),
                          textAlign: TextAlign.justify,
                        ),
                        Text(
                          widget.content?.content[_currentPage - 1].subtitle ??
                              "",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 13),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.11,
            // color: Colors.red,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: _currentPage > 1
                      ? NormalButton(
                          buttonText: "Previous",
                          colorBackgroundButton:
                              const Color.fromRGBO(21, 106, 142, 1),
                          colorBorderButton:
                              const Color.fromRGBO(21, 106, 142, 1),
                          onPressed: () => setState(() {
                            if (_currentPage > 1) {
                              _currentPage--;
                            }
                          }),
                        )
                      : Container(),
                ),
                Expanded(
                  flex: 1,
                  child: NormalButton(
                    buttonText: "Next",
                    colorBackgroundButton:
                        const Color.fromRGBO(21, 106, 142, 1),
                    colorBorderButton: const Color.fromRGBO(21, 106, 142, 1),
                    onPressed: () => setState(() {
                      if (_currentPage < _pages) {
                        _currentPage++;
                      } else if (_currentPage == _pages) {
                        Navigator.pop(context);
                      }
                    }),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
