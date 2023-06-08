import 'package:autosms_client/models/manager_element_model.dart';
import 'package:autosms_client/models/message_model.dart';

class SmsMessage extends Message {
  SmsMessage(
      {required super.id,
      required super.receptors,
      required super.updateDate,
      required super.state,
      required super.emiter,
      required super.message});
  @override
  static Message fromJson(Map<String, dynamic> json) {
    return SmsMessage(
        id: json["_id"],
        receptors: [],
        updateDate: DateTime.parse(json["updateDate"]),
        state: json["state"] == 0
            ? MessageState.noEnviado
            : json["state"] == 1
                ? MessageState.enCola
                : MessageState.enviado,
        emiter: json["emiter"],
        message: json["message"]);
  }

  @override
  Message toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
