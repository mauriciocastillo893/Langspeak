import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:langspeak/domain/models/chapter_content_model/chapter_content_model.dart';
import 'package:langspeak/ui/shared/season/season_iu_card.dart';

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final _seasonData = [
    {
      'season': '1',
      'season_name': 'Learn to build your CV',
      'chapters': [
        {
          'chapter': '1',
          'chapter_name': 'Build the basics ',
          'motto':
              'In this chapter you will be able to understand the basics of building a CV',
        },
        {
          'chapter': '2',
          'chapter_name': 'Templates',
          'motto':
              'In this chapter you will be able to learn and download about the available templates',
        },
        {
          'chapter': '3',
          'chapter_name': 'Where\'s my CV?',
          'motto': 'In this chapter you will be able send your CV for review',
        },
        {
          'chapter': '4',
          'chapter_name': 'What\'s my grade?',
          'motto':
              'In this chapter you will be able to look at your feedbacks from your attempts in chapter 3',
        }
      ],
    },
  ];

  final _request_to_chapter = {
    "season": 1,
    "seasonName": "LEARN TO BUILD YOUR CV",
    "chapterName": "BUILD THE BASICS",
    // El motto solo existe por cada capitulo, una temporada no tiene motto(lema)
    "motto": "Main points to introduce about a good interview",
    "content": [
      {
        "title": "The résumé format should not include a photograph.",
        "subtitle": "",
        "url_resources": [
          {"url": "http://example.com"},
          {"url": "http://example.com"}
        ]
      },
      {
        "title":
            "To ensure your information can be easily read by ATS (Applicant Tracking Systems), it should be designed in a single block of text, i.e., without columns.",
        "subtitle": "",
        "url_resources": [
          {"url": "http://example.com"},
          {"url": "http://example.com"}
        ]
      },
      {
        "title":
            "The sections that should appear are: Profile, Professional Experience, Education, Skills, and Languages.",
        "subtitle": "",
        "url_resources": [
          {"url": "http://example.com"},
          {"url": "http://example.com"}
        ]
      },
      {
        "title":
            "Use a brief profile, incorporating keywords that match the job requirements, and mention your main personal and professional qualities.",
        "subtitle": "",
        "url_resources": [
          {"url": "http://example.com"},
          {"url": "http://example.com"}
        ]
      },
      {
        "title":
            "By tailoring job offers, they have great visibility when applying for job vacancies",
        "subtitle":
            "If you are looking for a Frontend Position, you have to be sure that you have written technical skills according to the position or requirements set at the post.",
      },
      {
        "title": "Quantify and highlight your achievements.",
        "subtitle": "",
        "url_resources": [
          {"url": "http://example.com"},
          {"url": "http://example.com"}
        ]
      },
      {
        "title": "Ensure your résumé has no spelling or grammatical errors.",
        "subtitle":
            "Be sure about commas, capital letters, periods, among other punctuation marks",
      },
      {
        "title":
            "Use action verbs: This greatly helps recruiters understand the complexity of your tasks and assists ATS in processing your résumé.",
        "subtitle": "",
        "url_resources": [
          {"url": "http://example.com"},
          {"url": "http://example.com"}
        ]
      },
    ]
  };

  // Convert the map to a JSON string

  @override
  Widget build(BuildContext context) {
    String jsonString = jsonEncode(_request_to_chapter);

    // Decode the JSON string to an instance of ChapterUserContent
    ChapterUserContent chapterUserContent =
        chapterUserContentFromJson(jsonString);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: _seasonData.map((season) {
              return SeasonIuCard(
                margin: EdgeInsets.zero,
                season: season['season'] as String,
                seasonName: season['season_name'] as String,
                chapters: season['chapters'] as List<Map<String, dynamic>>,
                content: chapterUserContent,
                // onClick mandar evento indicando el "season_1", "chapter_1" para llamar la api
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
