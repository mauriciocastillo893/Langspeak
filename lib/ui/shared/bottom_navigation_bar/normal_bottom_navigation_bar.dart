import 'package:flutter/material.dart';

class NormalBottomNavigationBar extends StatefulWidget {
  const NormalBottomNavigationBar({super.key});

  @override
  State<NormalBottomNavigationBar> createState() =>
      _NormalBottomNavigationBarState();
}

class _NormalBottomNavigationBarState extends State<NormalBottomNavigationBar> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(51, 56, 78, 1),
      height: MediaQuery.of(context).size.height * 0.09,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildNavItem(Icons.chat, 0, 'Chats'),
          buildNavItem(Icons.update, 1, 'Updates'),
          buildNavItem(Icons.group, 2, 'Communities'),
          buildNavItem(Icons.call, 3, 'Calls'),
        ],
      ),
    );
  }

  Widget buildNavItem(IconData icon, int index, String label) {
    final bool isSelected = currentIndex == index;
    final Color color =
        isSelected ? Colors.white : const Color.fromARGB(255, 190, 190, 190);

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (isSelected)
              Positioned(
                bottom: 0,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  height: MediaQuery.of(context).size.height * 0.04,
                  // alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color),
                const SizedBox(height: 2),
                Text(
                  label,
                  style: TextStyle(color: color),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
