import 'package:dd_study_22_ui/data/services/auth_service.dart';
import 'package:dd_study_22_ui/ui/navigation/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class _ViewModelState {
  final String? login;
  final String? password;
  final bool isLoading;
  final String? errorText;
  const _ViewModelState({
    this.login,
    this.password,
    this.isLoading = false,
    this.errorText,
  });

  _ViewModelState copyWith({
    String? login,
    String? password,
    bool isLoading = false,
    String? errorText,
  }) {
    return _ViewModelState(
      login: login ?? this.login,
      password: password ?? this.password,
      isLoading: isLoading,
      errorText: errorText ?? this.errorText,
    );
  }
}

class _ViewModel extends ChangeNotifier {
  var loginTec = TextEditingController();
  var passwTec = TextEditingController();
  final _authService = AuthService();

  BuildContext context;
  _ViewModel({required this.context}) {
    loginTec.addListener(() {
      state = state.copyWith(login: loginTec.text);
    });
    passwTec.addListener(() {
      state = state.copyWith(password: passwTec.text);
    });
  }

  var _state = const _ViewModelState();
  _ViewModelState get state => _state;

  set state(_ViewModelState val) {
    _state = val;
    notifyListeners();
  }

  bool checkFields() {
    return (state.login?.isNotEmpty ?? false) &&
        (state.password?.isNotEmpty ?? false);
  }

  void login() async {
    state = state.copyWith(isLoading: true);

    try {
      await _authService.auth(state.login, state.password).then((value) {
        AppNavigator.toLoader().then(
          (value) => {state = state.copyWith(isLoading: false)},
        );
      });
    } on NoNetworkException {
      state = state.copyWith(errorText: "Нет сети!");
    } on WrongCredentionalException {
      state = state.copyWith(errorText: "Неверный логин или пароль!");
    } on ServerException {
      state = state.copyWith(
          errorText: "Приносим извинения, произошла ошибка на сервере!");
    }
  }
}

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();

    // return Scaffold(
    //     body: SafeArea(
    //         child: Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 20),
    //   child: Center(
    //       child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       TextField(
    //         controller: viewModel.loginTec,
    //         decoration: const InputDecoration(hintText: "Enter Login"),
    //       ),
    //       TextField(
    //           controller: viewModel.passwTec,
    //           obscureText: true,
    //           decoration: const InputDecoration(hintText: "Enter password")),
    //       ElevatedButton(
    //           onPressed: viewModel.checkFields() ? viewModel.login : null,
    //           child: const Text("Login")),
    //       if (viewModel.state.isLoading) const CircularProgressIndicator(),
    //       if (viewModel.state.errorText != null)
    //         Text(viewModel.state.errorText!)
    //     ],
    //   )),
    // )));

    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(),
                flex: 2,
              ),
              SvgPicture.asset(
                'assets/img/insta_logo.svg',
                color: Colors.black,
                height: 64,
              ),
              const SizedBox(height: 64),
              TextField(
                controller: viewModel.loginTec,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Введите E-mail',
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: viewModel.passwTec,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Введите пароль',
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed:
                              viewModel.checkFields() ? viewModel.login : null,
                          child: const Text("Войти"))),
                  const SizedBox(
                    width: 20,
                  ),
                  const Expanded(
                      child: ElevatedButton(
                          //
                          onPressed: AppNavigator.toRegister,
                          child: Text("Регистрация"))),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (viewModel.state.isLoading) const CircularProgressIndicator(),
              if (viewModel.state.errorText != null)
                Text(
                  viewModel.state.errorText!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              Flexible(
                flex: 3,
                child: Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget create() => ChangeNotifierProvider<_ViewModel>(
        create: (context) => _ViewModel(context: context),
        child: const Auth(),
      );
}
