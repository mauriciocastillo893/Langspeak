import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/app_bar/normal_app_bar.dart';
import 'package:langspeak/ui/shared/bottom_navigation_bar/normal_bottom_navigation_bar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const NormalAppBar(),
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
                );
              }).toList(),
            ),
          ),
        ),
        bottomNavigationBar: NormalBottomNavigationBar());
  }
}
