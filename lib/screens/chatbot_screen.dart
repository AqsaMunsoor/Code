import 'package:flutter/material.dart';
import 'package:flutter_gutter/flutter_gutter.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:google_fonts/google_fonts.dart';
import 'package:scalpinspector_app/animation.dart';

class ChatbotApp extends StatelessWidget {
  const ChatbotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatbotScreen(),
    );
  }
}

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  _ChatbotScreenState createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController _messageController = TextEditingController();
  List<ChatMessage> _chatMessages = [];
  late AnimationController _animationController;
  late Animation<Offset> _animation;
  bool _isAskingName = false;
  bool _isAskingAssistance = false;
  bool _isAskingCity = false;
  bool _isWaiting = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation =
        Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    _animationController.forward();
    _isAskingName = true;
    _addMessage(
      'Hi, how are you?',
      false,
      withDelay: true,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _handleSendMessage() {
    String message = _messageController.text.trim();
    if (message.isNotEmpty) {
      _messageController.clear();
      setState(() {
        _chatMessages.add(ChatMessage(text: message, isUserMessage: true));
      });
      _processUserMessage(message);
    }
  }

  void _processUserMessage(String message) {
    if (_isAskingName) {
      _isAskingName = false;
      _isAskingAssistance = true;
      _addMessage(
        'If you need assistance, I\'m available. (Yes/No)',
        false,
      );
    } else if (_isAskingAssistance) {
      _isAskingAssistance = false;
      if (message.toLowerCase() == 'no') {
        _addMessage(
          'Sure, thanks! Enjoy the rest of your day!',
          false,
        );
        _startTimer();
      } else if (message.toLowerCase() == 'yes') {
        _isAskingCity = true;
        _addMessage(
          'Please select your city from the options below: \n 1. Islamabad\n2. Rawalpindi\n3. Lahore\n4. Faisalabad\n5. Multan\n6. Gujranwala\n7. Sialkot\n8. Karachi\n9. Peshawar\n10. Abbottabad\n11. Jhelum',
          false,
        );
      }
    } else if (_isAskingCity) {
      _isAskingCity = false;
      _isWaiting = true;
      _addMessage(
        'Please wait while I fetch the details...',
        false,
      );
      _startTimer();
      _processCitySelection(message);
    }
  }

  void _processCitySelection(String city) {
    String clinicDetails = '';
    switch (city.toLowerCase()) {
      case 'islamabad':
        clinicDetails =
            'a. Clinic Name: Hair Transplant Islamabad\nContact Number: +92 300 2274494\nAddress: House No. 22, Street 10, F-8/3, Islamabad, Pakistan.\n\nb. Clinic Name: Dr. Amin\'s Hair Restoration Clinic\nContact Number: +92 334 3335775\nAddress: Plot 31, Street 37, F-7/1, Islamabad, Pakistan.';
        break;
      case 'rawalpindi':
        clinicDetails =
            'a. Clinic Name: Advanced Hair Center\nContact Number: +92 51 4450786\nAddress: House No. 123, Street 5, Chaklala Scheme III, Rawalpindi, Pakistan.\n\nb. Clinic Name: The Hair Clinic\nContact Number: +92 51 5125353\nAddress: Plaza 26-B, Main Peshawar Road, Rawalpindi, Pakistan.';
        break;
      case 'lahore':
        clinicDetails =
            'a. Clinic Name: Dr. Ahmad\'s Hair Transplant Clinic\nContact Number: +92 321 4615575\nAddress: 123-B, Block C, Faisal Town, Lahore, Pakistan.\n\nb. Clinic Name: Hair Club Lahore\nContact Number: +92 42 35874222\nAddress: 56-J, Gulberg III, Lahore, Pakistan.';
        break;
      case 'faisalabad':
        clinicDetails =
            'a. Clinic Name: Hair Transplant Faisalabad\nContact Number: +92 321 7710124\nAddress: 789-A, Peoples Colony No. 1, Faisalabad, Pakistan.\n\nb. Clinic Name: Dr. Ahsen\'s Hair Transplant Clinic\nContact Number: +92 321 6031111\nAddress: Jaranwala Road, Faisalabad, Pakistan.';
        break;
      case 'multan':
        clinicDetails =
            'a. Clinic Name: Hair Transplant Multan\nContact Number: +92 321 6636666\nAddress: 123-C, Gulgasht Colony, Multan, Pakistan.\n\nb. Clinic Name: Dr. Saeed\'s Hair Transplant Clinic\nContact Number: +92 300 6300702\nAddress: Abdali Road, Multan, Pakistan.';
        break;
      case 'gujranwala':
        clinicDetails =
            'a. Clinic Name: Hair Solutions Clinic\nContact Number: +92 55 3896622\nAddress: 22-D, Satellite Town, Gujranwala, Pakistan.\n\nb. Clinic Name: Dr. Hassan\'s Hair Clinic\nContact Number: +92 312 1119876\nAddress: 14-A, G Magnolia Park, Model Town, Gujranwala, Pakistan';
        break;
      case 'sialkot':
        clinicDetails =
            'a. Clinic Name: Hairline International Clinic\nContact Number: +92 52 1234567\nAddress: 45-C, Cantt Road, Sialkot Cantt, Sialkot, Pakistan.\n\nb. Clinic Name: Dr. Shahzad\'s Hair Restoration Clinic\nContact Number: +92 52 9876543\nAddress: 67-B, Khayaban-e-Iqbal, Sialkot, Pakistan.';
        break;
      case 'karachi':
        clinicDetails =
            'a. Clinic Name: Hair Care Specialists\nContact Number: +92 21 98765432\nAddress: 123, Main Shahrah-e-Faisal, Karachi, Pakistan.\n\nb. Clinic Name: Dr. Ali\'s Trichology Clinic\nContact Number: +92 21 87654321\nAddress: 55-A, Clifton Road, Block 9, Karachi, Pakistan.';
        break;
      case 'peshawar':
        clinicDetails =
            'a. Clinic Name: Hair Revive Clinic\nContact Number: +92 91 7654321\nAddress: 99, Hayatabad Medical Complex, Peshawar, Pakistan.\n\nb. Clinic Name: Dr. Rahim\'s Hair Restoration Center\nContact Number: +92 91 1234567\nAddress: 88, University Road, Peshawar, Pakistan.';
        break;
      case 'abbottabad':
        clinicDetails =
            'a. Clinic Name: Hair Transplant Abbottabad\nContact Number: +92 992 9876543\nAddress: 77, Jinnah Road, Abbottabad, Pakistan.\n\nb. Clinic Name: Dr. Aslam\'s Hair Solutions\nContact Number: +92 992 1234567\nAddress: 66, Supply Road, Abbottabad, Pakistan.';
        break;
      case 'jhelum':
        clinicDetails =
            'a. Clinic Name: Hair Restoration Jhelum\nContact Number: +92 544 7654321\nAddress: 33, Main GT Road, Jhelum, Pakistan.\n\nb. Clinic Name: Dr. Mansoor\'s Hair Clinic\nContact Number: +92 544 1234567\nAddress: 44, Cantt Area, Jhelum, Pakistan.';
        break;
      default:
        clinicDetails = 'Sorry, I don\'t have information for that city.';
    }
    _addMessage(
      clinicDetails,
      false,
    );
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(Duration(seconds: 15), () {
      setState(() {
        _isWaiting = false;
        _addMessage(
          'Thank you for chatting with me! If you have any more questions in the future, feel free to reach out. Have a great day!',
          false,
        );
      });
    });
  }

  Future<void> _addMessage(
    String text,
    bool isUserMessage, {
    bool withDelay = false,
  }) async {
    if (withDelay) {
      Future.delayed(Duration(seconds: 4), () {
        if (mounted) {
          // Check if the widget is still mounted before calling setState
          setState(() {
            _chatMessages
                .add(ChatMessage(text: text, isUserMessage: isUserMessage));
          });
        }
      });
    } else {
      if (mounted) {
        // Check if the widget is still mounted before calling setState
        setState(() {
          _chatMessages
              .add(ChatMessage(text: text, isUserMessage: isUserMessage));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/pink_back.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(
              color: Colors.white,
              size: 35,
            ),
          ),
          body: Column(
            children: [
              Column(
                children: [
                  FadeAnimation(
                    delay: 1,
                    child: SizedBox(
                      child: Image.network(
                          'https://cdn-icons-png.flaticon.com/128/6784/6784507.png'),
                      width: 100,
                      height: 100,
                    ),
                  ),
                ],
              ),
              Spacer(),
              Expanded(
                child: ListView.builder(
                  reverse: false,
                  itemCount: _chatMessages.length,
                  itemBuilder: (BuildContext context, int index) {
                    ChatMessage chatMessage = _chatMessages[index];
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Material(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: chatMessage.isUserMessage
                              ? Radius.circular(50)
                              : Radius.circular(0),
                          topRight: Radius.circular(50),
                          bottomRight: chatMessage.isUserMessage
                              ? Radius.circular(0)
                              : Radius.circular(50),
                        ),
                        color: chatMessage.isUserMessage
                            ? Colors.pink.shade200
                            : Colors.white,
                        elevation: 5,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: double.infinity,
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text(
                            chatMessage.text,
                            style: GoogleFonts.roboto(
                              color: chatMessage.isUserMessage
                                  ? Colors.white
                                  : Colors.pink.shade200,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type your question...',
                        ),
                      ),
                    ),
                    SizedBox(width: 8.0),
                    IconButton(
                      onPressed: _handleSendMessage,
                      icon: Icon(
                        Icons.send,
                        color: Colors.pink,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Chatbot'),
    //   ),
    //   body: Column(
    //     children: [
    //       SlideTransition(
    //         position: _animation,
    //         child: Container(
    //           padding: EdgeInsets.all(16.0),
    //           child: Column(
    //             children: [
    //               Image.asset(
    //                 'assets/robot_pic.png',
    //                 width: 60.0,
    //                 height: 60.0,
    //               ),
    //               SizedBox(height: 16.0),
    //               Text(
    //                 'How may I help you?',
    //                 style: TextStyle(
    //                   fontSize: 18.0,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //       Expanded(
    //         child: ListView.builder(
    //           reverse: false,
    //           itemCount: _chatMessages.length,
    //           itemBuilder: (BuildContext context, int index) {
    //             ChatMessage chatMessage = _chatMessages[index];
    //             return ListTile(
    //               title: Text(
    //                 chatMessage.text,
    //                 style: TextStyle(
    //                   color: chatMessage.isUserMessage
    //                       ? Colors.blue
    //                       : Colors.black,
    //                 ),
    //                 textAlign: chatMessage.isUserMessage
    //                     ? TextAlign.end
    //                     : TextAlign.start,
    //               ),
    //             );
    //           },
    //         ),
    //       ),
    //       Container(
    //         padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    //         child: Row(
    //           children: [
    //             Expanded(
    //               child: TextField(
    //                 controller: _messageController,
    //                 decoration: InputDecoration(
    //                   hintText: 'Type your question...',
    //                 ),
    //               ),
    //             ),
    //             SizedBox(width: 8.0),
    //             ElevatedButton(
    //               onPressed: _handleSendMessage,
    //               child: Text('Send'),
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class ChatMessage {
  final String text;
  final bool isUserMessage;

  ChatMessage({required this.text, required this.isUserMessage});
}
