import 'package:flutter/material.dart';

import '../core/app_theme.dart';
import '../core/l10n.dart';
import '../widgets/common.dart';
import 'home_shell.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> features = <String>[
      context.tr('onb.f1'),
      context.tr('onb.f2'),
      context.tr('onb.f3'),
      context.tr('onb.f4'),
    ];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 12, 22, 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Align(
                alignment: AlignmentDirectional.centerEnd,
                child: LanguageButton(),
              ),
              const SizedBox(height: 18),
              Row(
                children: <Widget>[
                  const LogoMark(size: 52),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          context.tr('app.name'),
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: context.strongText,
                          ),
                        ),
                        Text(
                          context.tr('app.tagline'),
                          style:
                              TextStyle(fontSize: 12.5, color: context.subtleText),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 190,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(26),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: <Color>[
                                    AppColors.primary.withOpacity(0.16),
                                    AppColors.sun.withOpacity(0.14),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 150,
                              width: 118,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18),
                                child: const LeafArt(showSpots: false),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 26),
                      Text(
                        context.tr('onb.title'),
                        style: TextStyle(
                          fontSize: 26,
                          height: 1.35,
                          fontWeight: FontWeight.w800,
                          color: context.strongText,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        context.tr('onb.subtitle'),
                        style: TextStyle(
                          fontSize: 14.5,
                          height: 1.7,
                          color: context.subtleText,
                        ),
                      ),
                      const SizedBox(height: 22),
                      ...features.map(
                        (String feature) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.12),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 15,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  feature,
                                  style: TextStyle(
                                    fontSize: 14,
                                    height: 1.5,
                                    color: context.strongText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              PrimaryButton(
                label: context.tr('onb.cta'),
                icon: Icons.arrow_forward,
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const HomeShell(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
