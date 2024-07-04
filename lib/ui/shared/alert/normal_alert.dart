import 'package:flutter/material.dart';

void showCustomAlert(
    {required BuildContext context,
    String title = 'Alert not configured properly',
    String message = 'Please configure the alert properly to show the message.',
    String primaryButtonText = 'Allow',
    String secondaryButtonText = "Don't Allow",
    VoidCallback? primaryButtonOnTap,
    VoidCallback? secondaryButtonOnTap,
    bool isSecondButton = false,
    Icon? icon = const Icon(Icons.warning, color: Colors.red, size: 40)}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        contentPadding: const EdgeInsets.only(top: 10.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 7.5),
            icon ?? const SizedBox(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(height: 1),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => primaryButtonOnTap != null
                        ? primaryButtonOnTap()
                        : (!isSecondButton
                            ? secondaryButtonOnTap != null
                                ? secondaryButtonOnTap()
                                : Navigator.of(context).pop()
                            : Navigator.of(context).pop()),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Text(
                        primaryButtonText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.045,
                        ),
                      ),
                    ),
                  ),
                ),
                if (isSecondButton)
                  Expanded(
                    child: InkWell(
                      onTap: () => secondaryButtonOnTap != null
                          ? secondaryButtonOnTap()
                          : Navigator.of(context).pop(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        decoration: const BoxDecoration(
                            // color: Colors.blue,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                            ),
                            border: Border(
                              left: BorderSide(
                                color: Colors.black26,
                                width: 1,
                              ),
                            )),
                        child: Text(
                          secondaryButtonText,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            // color: Colors.white,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
