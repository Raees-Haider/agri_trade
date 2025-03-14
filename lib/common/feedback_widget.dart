import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class FeedbackBottomSheet extends StatefulWidget {
  const FeedbackBottomSheet({Key? key}) : super(key: key);

  @override
  _FeedbackBottomSheetState createState() => _FeedbackBottomSheetState();
}

class _FeedbackBottomSheetState extends State<FeedbackBottomSheet> {
  final TextEditingController _feedbackController = TextEditingController();
  final FocusNode _feedbackFocusNode = FocusNode();
  bool _isSending = false;
  String? _errorText; // Holds error message

  Future<void> _sendFeedbackEmail() async {
    final feedback = _feedbackController.text.trim();
    if (feedback.isEmpty) {
      // Show error message and red border
      setState(() {
        _errorText = 'Enter your Report';
      });
      return;
    }

    setState(() {
      _isSending = true;
      _errorText = null; // Clear error message
    });

    try {
      final Email email = Email(
        body: feedback,
        recipients: ['hasnainmughal402@gmail.com'],
        subject: feedback.split(' ').take(7).toList().join(' '),
      );

      // Send email
      await FlutterEmailSender.send(email);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('feedback sent successfully'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('feedback not sent'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      // Reset sending state
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        top: 20,
        left: 20,
        right: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.3),
        //     spreadRadius: 2,
        //     blurRadius: 10,
        //     offset: Offset(0, -3),
        //   ),
        // ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Drag Handle
          // Container(
          //   width: 50,
          //   height: 5,
          //   margin: EdgeInsets.only(bottom: 15),
          //   decoration: BoxDecoration(
          //     color: Colors.grey[300],
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          // ),

          // Title
          Text(
            'Report',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          SizedBox(height: 15),

          // Feedback Text Area
          TextField(
            controller: _feedbackController,
            focusNode: _feedbackFocusNode,
            maxLines: 5,
            minLines: 4,
            decoration: InputDecoration(
              hintText: 'Enter your feedback or Report',
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: _errorText == null
                    ? BorderSide.none
                    : BorderSide(color: Colors.red, width: 1),
              ),
              errorText: _errorText, // Displays the error message
            ),
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            onChanged: (value) {
              if (_errorText != null && value.trim().isNotEmpty) {
                setState(() {
                  _errorText = null; // Clear error when text is entered
                });
              }
            },
          ),

          SizedBox(height: 20),

          // Submit Button
          ElevatedButton(
            onPressed: _isSending ? null : _sendFeedbackEmail,
            style: ElevatedButton.styleFrom(
              // backgroundColor: ,
              disabledBackgroundColor: Colors.grey[300],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: _isSending
                ? SizedBox(
                    child: CupertinoActivityIndicator(
                    color: Colors.white,
                  ))
                : Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    _feedbackFocusNode.dispose();
    super.dispose();
  }
}
