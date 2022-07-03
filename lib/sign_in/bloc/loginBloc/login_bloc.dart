import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rentall/bloc/loginBloc/login_event.dart';
import 'package:rentall/bloc/loginBloc/login_state.dart';
import 'package:rentall/data/repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userrepo;

  LoginBloc({required this.userrepo}) : super(LoginInitialState());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressedEvent) {
      yield LoginLoadingState();
      try {
        User? the_user =
            await userrepo.signInEmailAndPassword(event.email, event.password);
        yield LoginSuccessState(user: the_user!);
      } catch (e) {
        yield LoginFailedState(message: e.toString());
      }
    } else if (event is LoginByGoogleEvent) {
      yield LoginLoadingState();
      try {
        // User? theUser = (await userrepo.signInWithGoogle()) as User?;
        // yield LoginSuccessState(user: theUser!);
      } catch (e) {
        yield LoginFailedState(message: e.toString());
      }
    }
  }
}
