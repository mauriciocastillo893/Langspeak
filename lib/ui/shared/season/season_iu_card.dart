import 'package:flutter/material.dart';
import 'package:langspeak/domain/models/chapter_content_model/chapter_content_model.dart';
import 'package:langspeak/ui/pages/chapters/chapter_screen.dart';

class SeasonIuCard extends StatefulWidget {
  final EdgeInsets margin;
  final String season;
  final String seasonName;
  final ChapterUserContent? content;
  final List<Map<String, dynamic>> chapters;

  const SeasonIuCard({
    super.key,
    this.margin = const EdgeInsets.only(top: 16),
    this.content,
    required this.season,
    required this.seasonName,
    required this.chapters,
  });

  @override
  State<SeasonIuCard> createState() => _SeasonIuCardState();
}

class _SeasonIuCardState extends State<SeasonIuCard> {
  int _currentChapter = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: widget.margin,
      height: MediaQuery.of(context).size.height / 3,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(175, 93, 145, 139),
            Color(0xFF315C69),
          ],
        ),
        borderRadius: BorderRadius.circular(0),
      ),
      child: Column(
        children: [
          // Encabezado de la temporada
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              color: Colors.transparent,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.06,
                    height: MediaQuery.of(context).size.height * 0.05,
                    padding: const EdgeInsets.all(8.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0C4E6B),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: MediaQuery.of(context).size.height * 0.05,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 8),
                    decoration: const BoxDecoration(
                      color: Color(0xFF3F8ABF),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'SEASON ${widget.season}:',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.seasonName.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                                height: 1.1,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Contenido del capítulo
          Expanded(
            flex: 8,
            child: Container(
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Cuadrado lateral izquierdo
                  Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: 0.65,
                        heightFactor: 0.35,
                        child: Container(
                          // color: Colors.red,
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(38, 184, 204, 0.5),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8))),
                        ),
                      )),
                  // Contenido central
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'CHAPTER ${widget.chapters[_currentChapter]['chapter']}: ${widget.chapters[_currentChapter]['chapter_name'].toUpperCase()}',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.05),
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(
                                    19, 132, 183, 1), // Color de fondo
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: Colors.white),
                                onPressed: () {
                                  // Acción del botón anterior
                                  setState(() {
                                    if (_currentChapter > 0) {
                                      _currentChapter--;
                                    }
                                  });
                                },
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChapterScreen(
                                            content: widget.content,
                                          ))),
                              child: Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  color: const Color.fromRGBO(38, 154, 204, 1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(Icons.menu_book_rounded,
                                    size: 50, color: Colors.white),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left:
                                      MediaQuery.of(context).size.width * 0.05),
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(19, 132, 183, 1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    if (_currentChapter <
                                        widget.chapters.length - 1) {
                                      _currentChapter++;
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                          child: Text(
                            '${widget.chapters[_currentChapter]['motto'].toUpperCase()}',
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.025,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Cuadrado lateral derecho
                  Container(
                      width: MediaQuery.of(context).size.width * 0.1,
                      height: MediaQuery.of(context).size.height * 0.3,
                      decoration: const BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerRight,
                        widthFactor: 0.65,
                        heightFactor: 0.35,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Color.fromRGBO(38, 184, 204, 0.5),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8),
                                  bottomLeft: Radius.circular(8))),
                        ),
                      )),
                ],
              ),
            ),
          ),
          // Pie de página
        ],
      ),
    );
  }
}
