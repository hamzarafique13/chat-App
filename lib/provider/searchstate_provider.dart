import 'package:chat_app/model/freezedusermodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchEmailprovider = StateProvider<List<UserModel>>(
  (ref) => [],
);
