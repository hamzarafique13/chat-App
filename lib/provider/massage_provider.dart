import 'package:chat_app/model/chatmodel.dart';
import 'package:chat_app/model/massagemodel.dart';
import 'package:chat_app/services/firebaseservices.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final massagePageProvider =
    StateNotifierProvider<MassageProviderNotifier, List<MassageModel>>(
        (ref) => MassageProviderNotifier([]));

// final FirebaseAuth auth = FirebaseAuth.instance;
final Firebaseservices _firebaseservices = Firebaseservices();

class MassageProviderNotifier extends StateNotifier<List<MassageModel>> {
  MassageProviderNotifier(List<MassageModel>? initialmovie)
      : super(initialmovie ?? []);

  Future<void> fetchNewMassage(ChatModel chatModel) async {
    state = await _firebaseservices.featchMassagesToFirebase(chatModel);
  }
}
