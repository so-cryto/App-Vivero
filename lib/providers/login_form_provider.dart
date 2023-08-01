
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:productos_app/shared/shared.dart';


class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Email email;
  final Password password;

  LoginFormState({
    this.isPosting=false,
    this.isFormPosted=false,
    this.isValid=false,
    this.password=const Password.pure(),
    this.email=const Email.pure(),
  });

  LoginFormState copyWith({
    bool? isPosting,
    bool? isFormPosted,
    bool? isValid,
    Password? password,
    Email? email,
  })=>LoginFormState(
    isPosting: isPosting ?? this.isPosting,
    isFormPosted: isFormPosted ?? this.isFormPosted,
    isValid: isValid ?? this.isValid,
    password: password ?? this.password,
    email: email ?? this.email,
  );

  @override
  String toString() {
    return '''
      LoginFormState:
       isPosting : $isPosting
       isFormPosted : $isFormPosted
       isValid : $isValid
       email : $email
       password : $password
      ''';
  }
}
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  LoginFormNotifier():super(LoginFormState());
  onEmailChange(String value){
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      isValid: Formz.validate([newEmail,state.password])
    );
  }
  onPasswordChange(String value){
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      password: newPassword,
      isValid: Formz.validate([newPassword,state.email])
    );
  }
  onFormSubmit(){
    _touchEveryField();
    if(!state.isValid)return;
    // ignore: avoid_print
    print(state);
  }
  _touchEveryField(){
    final email =Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    state = state.copyWith(
      isFormPosted: true,
      email: email,
      password: password,
      isValid: Formz.validate([email,password]) 
    );
  }
}
final loginFormProvider = StateNotifierProvider.autoDispose<LoginFormNotifier,LoginFormState>((ref){
  return LoginFormNotifier();
});