import 'package:flutter/material.dart';

class NormalBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const NormalBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  State<NormalBottomNavigationBar> createState() =>
      _NormalBottomNavigationBarState();
}

class _NormalBottomNavigationBarState extends State<NormalBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromRGBO(51, 56, 78, 1),
      height: MediaQuery.of(context).size.height * 0.09,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildNavItem(Icons.home_outlined, Icons.home, 0, 'Home'),
          buildNavItem(Icons.chat_outlined, Icons.chat, 1, 'Chats'),
          buildNavItem(
              Icons.store_mall_directory_outlined, Icons.store, 2, 'Store'),
          buildNavItem(Icons.settings_outlined, Icons.settings, 3, 'Settings'),
        ],
      ),
    );
  }

  Widget buildNavItem(
      IconData iconOutlined, IconData iconFilled, int index, String label) {
    final bool isSelected = widget.selectedIndex == index;
    final Color color =
        isSelected ? Colors.white : const Color.fromARGB(255, 190, 190, 190);
    final IconData icon = isSelected ? iconFilled : iconOutlined;

    return GestureDetector(
      onTap: () {
        widget.onItemSelected(index);
      },
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width * 0.225,
        height: MediaQuery.of(context).size.height * 0.08,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 5.5,
              child: AnimatedContainer(
                width:
                    isSelected ? MediaQuery.of(context).size.width * 0.18 : 0,
                height: MediaQuery.of(context).size.height * 0.035,
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.blue.withOpacity(0.9)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color),
                const SizedBox(height: 6),
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
