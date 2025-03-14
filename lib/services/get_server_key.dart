import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> getServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];

    final client = await clientViaServiceAccount(
      ServiceAccountCredentials.fromJson({
        "type": "service_account",
        "project_id": "fyp1-8ec42",
        "private_key_id": "54daa3352f04ffe72c4912341557d80b5f58f8d6",
        "private_key":
            "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDACZFMA4VC5hXn\nziEOfezVPixQ2mhciRltVLVcOBfpXe3jpRu1kCMDFaefhA0UtdV8fazdqWHlulQj\nRL1F5zKeMcdlyDzGVUo2ZrFak0bGkDasc7Rjnr5kZ0IojzRAcsVZLDJu5O7McNvb\npM9ok2gQ+rwRbM8tfhXTvc0AcfVTkFMGSbu2bRJqfbBcubYpbaamG1nl5BdAkxHw\neYvkcVDqDwQskgDZDQ4U03K2k7cidv3VTBAbygLU4j+Ki+x6sI/QBo5AlN4on7n4\n6K7GwO3H1R1trbCDF2uKZ8juKLkOpt7mJMVpKPEIoQZJ66GYgjwmLIL0zPWuTLY7\nfYcIAjeLAgMBAAECggEALBDl+PHj3e6LP0ZzGm617lbWd3UutnE1Vvu1pCQxBHlr\n0a189sRM7HPHI5j7IXH6O5dhF/o6vyrrDK7E2eoMGPXmQgpZO8+teF9HOjgKaR0F\nlrv0PFncaZCyQzldLZ7If0ZfikfZLiuFn9ipSV9t5VuL1VnJDrDclFp81KnRuCtD\nCrMke8tEMZ62MNF2VrPNmkjcvFOia24q5yUcSwHb20d6/98MbDZsC/q6jgQOmPJh\nMxvCyjmeJow7SzmOPOVfvhVxo8720QYPEizVvvk0FwcgfQ9X16v+JViTIH/FuTYd\n7PNSIIiPedrVr2YtpE1IV9S7MReZoLbe8WPB1Y8FkQKBgQD6HGkniH1ddvo+ftnK\nYTv+nOwxJpV1m2PctQzZwa2lSV490xdS5OgraWaKG96Zje2tjGx7gk8dR9XyvAjR\nWpfcXmxL3KN0vi3ucxZxTWqD3uopetaEkZOqqNXDacY7wYC4k9OLQM0S0LDwO1Mx\nuZ2JiTwwl0lJEqIiPCJg9CR6EQKBgQDEjxuNQrvy3Z+e/E8lft+knN4cyRJxSCkv\nRM3Uekbgl6MXk8GtZWACo/TG4tuCSb8PqDps4GzFDSGDaskdE0joXELXsdJEII70\nKT5P0/f+pOYXs8GYwQcL1gZqpjyTVFGDbXTLnOl3CQI7YmkPtU65C7kXHq12P5Sf\n0vK+Nw4b2wKBgG9ZYLNZ/74xrv1NyjZgja4wPLMxI08lrBLhg+QaZu10OYG6zeJ4\nyKgzF5SbDcI9PriKEO33uLMnfSfA8QgLlhpk6z/m7dqWpKpJEI/G0In/Hy7yYjjI\n+v36hpimKbwGzQDfx0lywxoCURPSxZoYsfs+Xs6fO+BNbGNjdEbHysmRAoGALT78\nCqJn/VoC2mgeF/WCqbPqdRncAvOnd1gRQW38TsrZIh5DIRUK6tCvEfE6sl0jfAkv\nmcx3fUyugD/el7DOwZ4rTNeEHWaZQZ8U1u9mUNnIlYAtempEovbbd0VZAFkSgnx5\nvD0ciOgr+VuH77O+sV3/d1D6gRPVtIyskBjASK0CgYBYuRlijFIKYvibs0zaGC/A\nXpAAADGet6zSbhpL7txwyv3XTBXq+Jbw4j7kBC1KtJFTLCsoqfMvmoSPbXvtQ490\n3kBScfA6S2meiaQPSQqC0lqTjaPEnR4QCq3w0i9ltrbfT9q4l0TsClB51K7m4nTX\nL6mMpwyLH8MyQpRCD5Nj4w==\n-----END PRIVATE KEY-----\n",
        "client_email":
            "firebase-adminsdk-e4inb@fyp1-8ec42.iam.gserviceaccount.com",
        "client_id": "111671826507595014795",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url":
            "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-e4inb%40fyp1-8ec42.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }),
      scopes,
    );
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
