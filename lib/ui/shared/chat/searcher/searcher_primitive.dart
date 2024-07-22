import 'package:flutter/material.dart';
import 'package:langspeak/ui/shared/text_field/normal_text_field.dart';

class SearcherPrimitive extends StatefulWidget {
  final ValueChanged<String> onSearch;

  const SearcherPrimitive({super.key, required this.onSearch});

  @override
  State<SearcherPrimitive> createState() => _SearcherPrimitiveState();
}

class _SearcherPrimitiveState extends State<SearcherPrimitive> {
  final TextEditingController _searcherController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _searcherController.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _hasFocus = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: _hasFocus ? 0 : 10, right: 0),
      decoration: const BoxDecoration(
        color: Color.fromRGBO(21, 106, 142, 1),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          if (!_hasFocus) ...[
            const Icon(
              Icons.search,
              color: Colors.white,
            ),
            const SizedBox(
              width: 5,
            ),
          ],
          Expanded(
            child: NormalTextField(
              controller: _searcherController,
              focusNode: _focusNode,
              hintText: 'Search',
              suffixIcon: _hasFocus ? const Icon(Icons.close) : null,
              colorBorder: Colors.transparent,
              colorBackground: Colors.transparent,
              padding: EdgeInsets.zero,
              onIconPressed: () {
                _searcherController.clear();
              },
              onChanged: (v) => widget.onSearch(v),
            ),
          ),
        ],
      ),
    );
  }
}
