import 'package:flutter/material.dart';
import 'package:langspeak/infrastructure/helpers/geolocator/geolocator_helper.dart';
import 'package:langspeak/infrastructure/helpers/shared_preferences/user_shared_preferences.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';

class StatusCredentials extends StatefulWidget {
  final bool hasChanges;
  final bool userIdAvailable;
  final double fontSize;

  const StatusCredentials(
      {super.key,
      this.hasChanges = false,
      this.userIdAvailable = true,
      this.fontSize = 14});

  @override
  State<StatusCredentials> createState() => _StatusCredentialsState();
}

// PROBABLEMENTE REQUIERA SER MANEJADO POR BLOC PARA SU ACTUALIZACION CORRECTA
class _StatusCredentialsState extends State<StatusCredentials> {
  final UserSharedPreferences _userSharedPreferences = UserSharedPreferences();
  final String userId = "1234567890ABC";
  String _username = "-";
  String _country = "México";

  @override
  void initState() {
    super.initState();
    _setUserCredentials();
    _setCurrentLocation();
  }

  void _setUserCredentials() {
    _userSharedPreferences.getUserCredentials().then((userCredentials) {
      setState(() {
        _username = userCredentials['username'] as String;
      });
    });
  }

  void _setCurrentLocation() {
    GeolocatorHelper.getCurrentLocation().then((result) {
      setState(() {
        _country = result['country'] as String;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hasChanges) {
      _setUserCredentials();
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NormalText(
          text: _username,
          alignment: Alignment.centerLeft,
          textStyle: TextStyle(
            color: Colors.white,
            height: 1.15,
            fontSize: widget.fontSize,
          ),
        ),
        NormalText(
            text: _country,
            alignment: Alignment.centerLeft,
            textStyle: widget.userIdAvailable
                ? TextStyle(
                    color: Colors.white,
                    height: 1.15,
                    fontSize: widget.fontSize)
                : TextStyle(
                    color: const Color.fromARGB(255, 219, 219, 219),
                    height: 1.15,
                    fontSize: widget.fontSize)),
        if (widget.userIdAvailable)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.0225,
            child: Row(
              children: [
                NormalText(
                  text: "My User ID: $userId",
                  alignment: Alignment.centerLeft,
                  textStyle: TextStyle(
                    fontSize: widget.fontSize * 0.7,
                    color: const Color.fromARGB(255, 219, 219, 219),
                  ),
                ),
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.width * 0.055,
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.width * -0.0425,
                      right: MediaQuery.of(context).size.width * 0.005,
                      child: IconButton(
                        icon: Icon(
                          Icons.copy,
                          size: MediaQuery.of(context).size.width * 0.03,
                          color: const Color.fromARGB(255, 219, 219, 219),
                        ),
                        onPressed: () => UserSharedPreferences.copyToClipboard(
                            context: context,
                            textToClipboard: userId,
                            message: "User ID copied to clipboard."),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
