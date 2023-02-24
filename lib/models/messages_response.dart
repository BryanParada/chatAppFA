 
import 'dart:convert';

MessagesResponse messagesResponseFromMap(String str) => MessagesResponse.fromMap(json.decode(str));

String messagesResponseToMap(MessagesResponse data) => json.encode(data.toMap());

class MessagesResponse {
    MessagesResponse({
        required this.ok,
        required this.msg,
        required this.messages,
    });

    bool ok;
    String msg;
    List<Message> messages;

    factory MessagesResponse.fromMap(Map<String, dynamic> json) => MessagesResponse(
        ok: json["ok"],
        msg: json["msg"],
        messages: List<Message>.from(json["messages"].map((x) => Message.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "ok": ok,
        "msg": msg,
        "messages": List<dynamic>.from(messages.map((x) => x.toMap())),
    };
}

class Message {
    Message({
        required this.from,
        required this.to,
        required this.msg,
        required this.createdAt,
        required this.updatedAt,
    });

    String from;
    String to;
    String msg;
    DateTime createdAt;
    DateTime updatedAt;

    factory Message.fromMap(Map<String, dynamic> json) => Message(
        from: json["from"],
        to: json["to"],
        msg: json["msg"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toMap() => {
        "from": from,
        "to": to,
        "msg": msg,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
