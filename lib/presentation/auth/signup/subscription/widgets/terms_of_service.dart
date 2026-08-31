import 'package:bendrummond1819_fo529642dc3c7/core/resource/constants/color_manger.dart';
import 'package:bendrummond1819_fo529642dc3c7/core/route/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsOfService extends StatelessWidget {
  const TermsOfService({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: () {
            openUrl(RoutesName.privacyPolicy);
          },
          child: Text(
            'Privacy Policy',
            style: TextStyle(
              color: ColorManager.gold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),

        const Text(' | ', style: TextStyle(color: Colors.grey)),

        TextButton(
          onPressed: () {
            openUrl(RoutesName.termsofEULA);
          },
          child: Text(
            'Terms of Use (EULA)',
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: ColorManager.gold,
            ),
          ),
        ),
      ],
    );
  }

  //======= Helper Method =========

  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
