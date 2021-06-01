import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Question extends StatefulWidget {
  
 final  String questionText;
 Question(this.questionText);

  @override
  _QuestionState createState() => _QuestionState();
}

enum TtsState { playing, stopped }

class _QuestionState extends State<Question> {
  

  FlutterTts flutterTts;
  dynamic languages;
  //bool isPlaying = false;
  String language;
  double volume = 1.5;
  double pitch = 1.0;
  double rate = 1.0;

  // String _newVoiceText;

  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;

  get isStopped => ttsState == TtsState.stopped;

  @override
  initState() {
    super.initState();
    initTts();
  }

  initTts() {
    flutterTts = FlutterTts();

    // _getLanguages();

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  // Future _getLanguages() async {
  //   languages = await flutterTts.getLanguages;
  //   print("pritty print ${languages}");
  //   if (languages != null) setState(() => languages);
  // }

  Future _speak(String questionText) async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (questionText != null) {
      if (questionText.isNotEmpty) {
        var result = await flutterTts.speak(questionText);
        if (result == 1) setState(() => ttsState = TtsState.playing);
      }
    }
  }

  Future _stop() async {
    var result = await flutterTts.stop();
    if (result == 1) setState(() => ttsState = TtsState.stopped);
  }

  void setTtsLanguage() async {
    await flutterTts.setLanguage("en-US");
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts.stop();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        child: Stack(
      fit: StackFit.expand,
      children: [
        Positioned.fill(
            child: Container(
          width: double.infinity,
          margin: EdgeInsets.all(10),
          child: Text(
            widget.questionText,
            style: TextStyle(fontSize: 28),
            textAlign: TextAlign.center,
          ),
        ),
        
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 50,
          width: double.maxFinite,
          decoration: BoxDecoration(boxShadow: [
            new BoxShadow(
               color: Colors.black,
               blurRadius: 2.0,
            ),
          ],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))
          ),
          child: 
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                icon: Icon(Icons.volume_down),
                onPressed: (){
                  _speak(widget.questionText);
                },
              )
            ],),
        )
      )
      ],
    )

        //Text
        ); //Contaier
  }

//   Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
//       String label, Function func) {
//     return Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//               icon: Icon(icon),
//               color: color,
//               splashColor: splashColor,
//               onPressed: () => func()),
//           Container(
//               margin: const EdgeInsets.only(top: 8.0),
//               child: Text(label,
//                   style: TextStyle(
//                       fontSize: 12.0,
//                       fontWeight: FontWeight.w400,
//                       color: color)))
//         ]);
//   }

//   bottomBar() => Container(
//         margin: EdgeInsets.all(10.0),
//         height: 50,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             FloatingActionButton(
//               heroTag: null,
//               onPressed: _speak(questionText),
//               child: Icon(Icons.volume_up),
//               backgroundColor: Colors.grey,
//             ),
//             FloatingActionButton(
//               heroTag: null,
//               onPressed: _stop,
//               backgroundColor: Colors.grey,
//               child: Icon(Icons.stop),
//             ),
//           ],
//         ),
//       );
 }
