import 'package:flutter/material.dart';
import 'package:langspeak/infrastructure/helpers/geolocator/geolocator_helper.dart';
import 'package:langspeak/infrastructure/helpers/shared_preferences/user_shared_preferences.dart';
import 'package:langspeak/ui/shared/profile_photo/profile_photo.dart';
import 'package:langspeak/ui/shared/text/normal_text.dart';

class StatusMain extends StatefulWidget {
  final bool hasChanges;
  final bool userIdAvailable;
  final Alignment containerAlignment;
  final double containerHeight;
  final double containerWidth;
  final double containerBorderRadius;
  final Color containerColor;
  // ProfilePhoto
  final double profilePhotoSize;
  final double profilePhotoBorderWidth;
  final double profilePhotoHeightFactor;
  final double profilePhotoWidthFactor;
  final bool profilePhotoIsEditable;
  final Color profilePhotoBorderColor;

  const StatusMain({
    super.key,
    this.hasChanges = false,
    this.userIdAvailable = true,
    this.containerAlignment = Alignment.center,
    this.containerHeight = 0.12,
    this.containerWidth = 0.85,
    this.containerBorderRadius = 10,
    this.containerColor = const Color.fromRGBO(21, 106, 142, 1),
    this.profilePhotoSize = 80,
    this.profilePhotoBorderWidth = 2,
    this.profilePhotoHeightFactor = 0.6,
    this.profilePhotoWidthFactor = 0.6,
    this.profilePhotoIsEditable = true,
    this.profilePhotoBorderColor = Colors.white,
  });

  @override
  State<StatusMain> createState() => _StatusMainState();
}

// PROBABLEMENTE REQUIERA SER MANEJADO POR BLOC PARA SU ACTUALIZACION CORRECTA
// PROBABLEMENTE REQUIERA SER MANEJADO POR BLOC PARA SU ACTUALIZACION CORRECTA
// PROBABLEMENTE REQUIERA SER MANEJADO POR BLOC PARA SU ACTUALIZACION CORRECTA
// PROBABLEMENTE REQUIERA SER MANEJADO POR BLOC PARA SU ACTUALIZACION CORRECTA
// PROBABLEMENTE REQUIERA SER MANEJADO POR BLOC PARA SU ACTUALIZACION CORRECTA
class _StatusMainState extends State<StatusMain> {
  final UserSharedPreferences userSharedPreferences = UserSharedPreferences();
  String _username = "-";
  String _country = "México";
  final String userId = "1234567890ABC";
  final UserSharedPreferences _userSharedPreferences = UserSharedPreferences();

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
    return Align(
      alignment: widget.containerAlignment,
      child: Container(
        height: MediaQuery.of(context).size.height * widget.containerHeight,
        width: MediaQuery.of(context).size.width * widget.containerWidth,
        decoration: BoxDecoration(
          color: widget.containerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            ProfilePhoto(
                size: widget.profilePhotoSize,
                borderWidth: widget.profilePhotoBorderWidth,
                heightFactor: widget.profilePhotoHeightFactor,
                widthFactor: widget.profilePhotoWidthFactor,
                isEditable: widget.profilePhotoIsEditable,
                borderColor: widget.profilePhotoBorderColor),
            Container(
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius:
                    BorderRadius.circular(widget.containerBorderRadius),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NormalText(
                    text: _username,
                    alignment: Alignment.centerLeft,
                  ),
                  NormalText(
                      text: _country,
                      alignment: Alignment.centerLeft,
                      textStyle: widget.userIdAvailable
                          ? const TextStyle(color: Colors.white, height: 1.15)
                          : const TextStyle(
                              color: Color.fromARGB(255, 219, 219, 219),
                              height: 1.15)),
                  if (widget.userIdAvailable)
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.0225,
                      child: Row(
                        children: [
                          NormalText(
                            text: "My User ID: $userId",
                            alignment: Alignment.centerLeft,
                            textStyle: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.025,
                              color: const Color.fromARGB(255, 219, 219, 219),
                            ),
                          ),
                          Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.055,
                                width: MediaQuery.of(context).size.width * 0.1,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              Positioned(
                                top:
                                    MediaQuery.of(context).size.width * -0.0425,
                                child: IconButton(
                                  icon: Icon(
                                    Icons.copy,
                                    size: MediaQuery.of(context).size.width *
                                        0.04,
                                    color: Colors.white,
                                  ),
                                  onPressed: () =>
                                      UserSharedPreferences.copyToClipboard(
                                          context: context,
                                          textToClipboard: userId,
                                          message:
                                              "User ID copied to clipboard."),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
