import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TextandMore extends StatelessWidget {
  const TextandMore({
    Key? key,
    required String? userName,
    required GoogleSignInAccount? user,
    required String? userEmail,
  })  : _userName = userName,
        _user = user,
        _userEmail = userEmail,
        super(key: key);

  final String? _userName;
  final GoogleSignInAccount? _user;
  final String? _userEmail;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              shadows: [
                Shadow(offset: Offset(0, 0), blurRadius: 1, color: Colors.black87)
              ],
            ),
            children: [
              const TextSpan(text: 'Usuario: '),
              TextSpan(
                text: _userName ?? _user?.displayName ?? '',
                style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.blueGrey,),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              shadows: [
                Shadow(offset: Offset(0, 0), blurRadius: 1, color: Colors.black87)
              ],
            ),
            children: [
              const TextSpan(text: 'Email: '),
              TextSpan(
                text: _userEmail ?? _user?.email ?? '',
                style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.blueGrey,),
              ),
            ],
          ),
        ),
      ],
    );
  }
}