import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../navigator_service.dart';
import '../../../../utils/colors.dart';
import '../../../status/presentation/bloc/status/bloc.dart';
import '../../../status/presentation/pages/status_screen.dart';

abstract class InfoStrings {
  static const aboutFirstSection =
      'Coronaviruses (CoV) are a large family of viruses that cause illness ranging from the common cold to more severe diseases such as Middle East Respiratory Syndrome (MERS-CoV) and Severe Acute Respiratory Syndrome (SARS-CoV).';
  static const aboutSecondSection = '(SARS-CoV). A novel coronavirus (nCoV) is a new strain that has not been previously identified in humans.';
  static const aboutThirdSection =
      'Coronaviruses are zoonotic, meaning they are transmitted between animals and people. Detailed investigations found that SARS-CoV was transmitted from civet cats to humans and MERS-CoV from dromedary camels to humans';
  static const aboutFourthSection = 'Several known coronaviruses are circulating in animals that have not yet infected humans.';
}

class InfoScreen extends StatefulWidget {
  final AnimationController animationController;

  const InfoScreen({Key key, this.animationController}) : super(key: key);
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  List<Widget> listViews = List<Widget>();

  NavigatorService _service;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _service = NavigatorProvider.of(context).service;

    return BlocBuilder<StatusBloc, StatusesState>(
      builder: (context, state) {
        if (_service.previousPages.last is InfoScreen) {
          _service.previousPages.removeLast();
          _service.currentPage = StatusScreen();
          BlocProvider.of<StatusBloc>(context).add(LoadStatuses());
        }

        return Scaffold(
          body: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 60),
                child: ListView(
                  children: <Widget>[
                    _buildAboutParagraph(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAboutParagraph() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: DaintyColors.nearlyWhite,
          boxShadow: [
            BoxShadow(
              color: DaintyColors.grey.withOpacity(0.2),
              blurRadius: 20,
              spreadRadius: 20,
              offset: Offset(5.0, 5.0),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            AutoSizeText(
              InfoStrings.aboutFirstSection,
              style: TextStyle(fontSize: 16),
              softWrap: true,
              maxLines: 5,
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: AutoSizeText(
                InfoStrings.aboutSecondSection,
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),
                softWrap: true,
                maxLines: 5,
                textAlign: TextAlign.center,
              ),
            ),
            AutoSizeText(
              InfoStrings.aboutThirdSection,
              style: TextStyle(fontSize: 16),
              softWrap: true,
              maxLines: 5,
              textAlign: TextAlign.justify,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: AutoSizeText(
                InfoStrings.aboutFourthSection,
                style: TextStyle(fontSize: 16),
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: GestureDetector(
                onTap: () async {
                  if (await canLaunch('https://www.who.int/health-topics/coronavirus')) {
                    await launch('https://www.who.int/health-topics/coronavirus');
                  }
                },
                child: AutoSizeText.rich(
                  TextSpan(
                    text: 'https://www.who.int/health-topics/coronavirus',
                    style: TextStyle(
                      color: DaintyColors.primary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
