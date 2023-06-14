import 'package:autosms_client/models/contact_model.dart';
import 'package:autosms_client/models/group_model.dart';
import 'package:autosms_client/models/manager_element_model.dart';
import 'package:autosms_client/models/message_model.dart';
import 'package:get/get.dart';

class Email extends Message {
  String subject;
  Email(
      {required super.id,
      required super.receptors,
      required super.updateDate,
      super.sendDate,
      required super.state,
      required super.emiter,
      required super.message,
      required this.subject});
  @override
  static Message fromJson(Map<String, dynamic> json) {
    DateTime? sendDate =
        json["sendDate"] != null ? DateTime.parse(json["sendDate"]) : null;
    List<ManagerElement> receptors = [];
    json["receptors"].forEach((element) => receptors.add(
        element["__t"] == "Contact"
            ? Contact.fromJson(element)
            : Group.fromJson(element)));
    return Email(
        id: json["_id"],
        receptors: receptors,
        updateDate: DateTime.parse(json["updateDate"]),
        state: json["state"] == 0
            ? MessageState.noEnviado.obs
            : json["state"] == 1
                ? MessageState.enCola.obs
                : MessageState.enviado.obs,
        emiter: json["emiter"],
        sendDate: sendDate,
        message: json["message"],
        subject: json["subject"]);
  }

  @override
  Map<String, dynamic> toJson() {
    throw UnimplementedError();
  }
}
