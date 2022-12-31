import 'package:app_presensi/resources/widgets/shared/button.dart';
import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.btnLeft,
    required this.btnRight,
    required this.onPresLeft,
    required this.onPresRight,
  }) : super(key: key);
  final String title, subtitle, btnLeft, btnRight;
  final void Function() onPresLeft, onPresRight;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14), color: Colors.white),
        height: 172,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0XFFD3DAE0),
                ),
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 36,
                ),
                Expanded(
                  child: Button(
                    onPres: onPresLeft,
                    minimunSize: const Size(double.infinity, 46),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.77),
                    ),
                    child: Text(btnLeft),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: onPresRight,
                    style: ButtonStyle(
                      minimumSize: const MaterialStatePropertyAll(
                        Size(double.infinity, 46),
                      ),
                      textStyle: const MaterialStatePropertyAll(
                        TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.77),
                        ),
                      ),
                    ),
                    child: Text(btnRight),
                  ),
                ),
                const SizedBox(
                  width: 36,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}