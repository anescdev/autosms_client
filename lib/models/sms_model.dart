import 'package:autosms_client/models/manager_element_model.dart';
import 'package:autosms_client/models/message_model.dart';
import 'package:get/get_rx/get_rx.dart';

class SmsMessage extends Message {
  SmsMessage(
      {required super.id,
      required super.receptors,
      required super.updateDate,
      required super.state,
      super.sendDate,
      required super.emiter,
      required super.message});
  @override
  static Message fromJson(Map<String, dynamic> json) {
    DateTime? sendDate =
        json["sendDate"] != null ? DateTime.parse(json["sendDate"]) : null;
    return SmsMessage(
        id: json["_id"],
        receptors: [],
        updateDate: DateTime.parse(json["updateDate"]),
        state: json["state"] == 0
            ? MessageState.noEnviado.obs
            : json["state"] == 1
                ? MessageState.enCola.obs
                : MessageState.enviado.obs,
        emiter: json["emiter"],
        sendDate: sendDate,
        message: json["message"]);
  }

  @override
  Message toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
