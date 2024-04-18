import 'package:flutter/material.dart';
import 'package:flutter_start/flutter_start.dart';

IntroductionOptions defaultIntroductionOptions = IntroductionOptions(
  introductionTranslations: const IntroductionTranslations(
    finishButton: 'Get Started',
    nextButton: 'Next',
    previousButton: 'Previous',
  ),
  buttonMode: IntroductionScreenButtonMode.text,
  indicatorMode: IndicatorMode.dot,
  buttonBuilder: (p0, p1, p2, p3) => defaultIntroductionButton(p0, p1, p2),
  introductionButtonTextstyles: defaultIntroductionButtonTextstyles,
  pages: defaultIntroductionPages,
);

const titleStyle = TextStyle(
  color: Color(0xff71C6D1),
  fontSize: 24,
  fontWeight: FontWeight.w700,
);

final defaultIntroductionPages = [
  IntroductionPage(
    decoration: const BoxDecoration(
      color: Color(0xffFAF9F6),
    ),
    title: const Column(
      children: [
        SizedBox(height: 100),
        Text('welcome to iconinstagram', style: titleStyle),
        SizedBox(height: 6),
        Text(
          'Welcome to the world of Instagram, where creativity'
          ' knows no bounds and connections are made'
          ' through captivating visuals.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    text: const Text(''),
  ),
  IntroductionPage(
    decoration: const BoxDecoration(
      color: Color(0xffFAF9F6),
    ),
    title: const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 100),
        Text(
          'discover iconinstagram',
          style: titleStyle,
        ),
        SizedBox(height: 6),
        Text(
          'Dive into the vibrant world of'
          ' Instagram and discover endless possibilities.'
          ' From stunning photography to engaging videos,'
          ' Instagram offers a diverse range of content to explore and enjoy.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    text: const Text(''),
  ),
  IntroductionPage(
    decoration: const BoxDecoration(
      color: Color(0xffFAF9F6),
    ),
    title: const Column(
      children: [
        SizedBox(height: 100),
        Text(
          'elevate your experience',
          style: titleStyle,
        ),
        SizedBox(height: 6),
        Text(
          'Whether promoting your business, or connecting'
          ' with friends and family, Instagram provides the'
          ' tools and platform to make your voice heard.',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
    text: const Text(''),
  ),
];

const defaultIntroductionButtonTextstyles = IntroductionButtonTextstyles(
  finishButtonStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  nextButtonStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  previousButtonStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
  skipButtonStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
  ),
);

Widget defaultIntroductionButton(
  BuildContext context,
  void Function() onTap,
  Widget buttonWidget,
) =>
    InkWell(
      onTap: onTap,
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(
              0xff979797,
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: buttonWidget,
          ),
        ),
      ),
    );
