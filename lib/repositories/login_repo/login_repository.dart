import '../../base/provider/api_provider';
import '../../model/information.dart';

abstract class LoginRepository {
  Future<Information> getInformation(String email, String password);

  LoginRepository(ApiProvider apiProvider);
}
