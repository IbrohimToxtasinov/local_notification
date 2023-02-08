import 'dart:convert';
import 'package:http/http.dart' as https;
import 'package:http/http.dart';

class NotificationApiService {
  static Future<String> sendNotificationToAll() async {
    String key =
        "key=AAAA6tZfBRk:APA91bHuuZJONNzrgIZAhF-nGOYk89H_Op6vldT4kkkGOFI6dNg8MU2YnNrpLZNdCjBfj7IkSrqxVbbZynVbqCHyY6qQr9B3AAi6n7wlaH-SXNXJyacUi0kFKqnLgf3hP6GNEXRJBgTP";

    Map<String, dynamic> body = {
      "to": "/topics/news",
      "notification": {"title": "Xabar keldi", "body": "Task bajarildi"},
      "data": {
        "title" : "Task Bajarildi",
        "description" : "Task Bajarildi",
        "image" : "https://source.unsplash.com/random/5",
        "route":"/news_route"
      }
    };

    Uri uri = Uri.parse("https://fcm.googleapis.com/fcm/send");
    try {
      Response response = await https.post(
        uri,
        headers: {
          "Authorization": key,
          "Content-Type": "application/json",
        },
        body: json.encode(body),
      );
      if (response.statusCode == 200) {
        return jsonDecode(response.body)["message_id"].toString();
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}