import 'package:autosms_client/models/manager_element_model.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

abstract class Message {
  String id;
  List<ManagerElement> receptors;
  DateTime updateDate;
  DateTime? sendDate;
  Rx<MessageState> state;
  String emiter;
  String message;
  Message(
      {required this.id,
      required this.receptors,
      required this.updateDate,
      this.sendDate,
      required this.state,
      required this.emiter,
      required this.message});
  Message toJson();
}

enum MessageState { noEnviado, enCola, enviado }
