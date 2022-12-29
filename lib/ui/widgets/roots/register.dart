import 'package:dd_study_22_ui/data/services/auth_service.dart';
import 'package:dd_study_22_ui/data/services/register_services.dart';
import 'package:dd_study_22_ui/ui/navigation/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class _ViewModelState {
  final String? name;
  final String? email;
  final String? password;
  final String? retryPassword;
  final DateTime? birthDate;
  final bool isLoading;
  final String? errorText;
  const _ViewModelState({
    this.name,
    this.email,
    this.password,
    this.retryPassword,
    this.birthDate,
    this.isLoading = false,
    this.errorText,
  });

  _ViewModelState copyWith({
    String? name,
    String? email,
    String? password,
    String? retryPassword,
    DateTime? birthDate,
    bool isLoading = false,
    String? errorText,
  }) {
    return _ViewModelState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      retryPassword: retryPassword ?? this.retryPassword,
      birthDate: birthDate ?? this.birthDate,
      isLoading: isLoading,
      errorText: errorText ?? this.errorText,
    );
  }
}

class _ViewModel extends ChangeNotifier {
  var nameTec = TextEditingController();
  var emailTec = TextEditingController();
  var passwordTec = TextEditingController();
  var retryPasswordTec = TextEditingController();
  var birthDateTec = TextEditingController();

  final _time = TextEditingController();
  final _date = TextEditingController();

  DateTime selectedDateTime = DateTime.now();

  final _registerService = RegisterService();

  BuildContext context;
  _ViewModel({required this.context}) {
    nameTec.addListener(() {
      state = state.copyWith(name: nameTec.text);
    });
    emailTec.addListener(() {
      state = state.copyWith(email: emailTec.text);
    });
    passwordTec.addListener(() {
      state = state.copyWith(password: passwordTec.text);
    });
    retryPasswordTec.addListener(() {
      state = state.copyWith(retryPassword: retryPasswordTec.text);
    });
  }

  var _state = const _ViewModelState();
  _ViewModelState get state => _state;
  set state(_ViewModelState val) {
    _state = val;
    notifyListeners();
  }

  bool checkFields() {
    return (state.name?.isNotEmpty ?? false) &&
        (state.email?.isNotEmpty ?? false) &&
        (state.password?.isNotEmpty ?? false) &&
        (state.retryPassword?.isNotEmpty ?? false);
  }

  void register() async {
    state = state.copyWith(isLoading: true);

    try {
      await _registerService
          .registerUser(state.name, state.email, state.password,
              state.retryPassword, selectedDateTime)
          .then((value) {
        AppNavigator.toAuth();
      });
    } on NoNetworkException {
      state = state.copyWith(errorText: "Нет сети!");
    } on WrongCredentionalException {
      state = state.copyWith(errorText: "Неверный логин или пароль");
    } on ServerException {
      state = state.copyWith(errorText: "Произошла ошибка на сервере");
    }
  }
}

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var viewModel = context.watch<_ViewModel>();
    var df = DateFormat("dd.MM.yyyy");
    var tf = DateFormat("HH:mm");
    const double sepheight = 10;

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
                flex: 2,
                child: Container(),
              ),
              SvgPicture.asset(
                'assets/img/insta_logo.svg',
                color: Colors.black,
                height: 64,
              ),
              const SizedBox(height: 64),
              TextField(
                controller: viewModel.nameTec,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: 'Придумайте никнейм',
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
              const SizedBox(
                height: sepheight,
              ),
              TextField(
                controller: viewModel.emailTec,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Укажите Ваш E-Mail адрес',
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
              const SizedBox(
                height: sepheight,
              ),
              TextField(
                controller: viewModel.passwordTec,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Придумайте пароль',
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
              const SizedBox(
                height: sepheight,
              ),
              TextField(
                controller: viewModel.retryPasswordTec,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Повторите пароль',
                  border: inputBorder,
                  focusedBorder: inputBorder,
                  enabledBorder: inputBorder,
                  filled: true,
                  contentPadding: const EdgeInsets.all(8),
                ),
              ),
              const SizedBox(
                height: sepheight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: TextField(
                      controller: viewModel._date,
                      decoration: InputDecoration(
                        hintText: 'Дата рождения',
                        border: inputBorder,
                        focusedBorder: inputBorder,
                        enabledBorder: inputBorder,
                        filled: true,
                        contentPadding: const EdgeInsets.all(8),
                      ),
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1950, 1, 1),
                            maxTime: DateTime.now(), onConfirm: (date) {
                          viewModel._date.text = df.format(date);

                          final newDateTime = DateTime(
                            date.year,
                            date.month,
                            date.day,
                            viewModel.selectedDateTime.hour,
                            viewModel.selectedDateTime.minute,
                          );

                          viewModel.selectedDateTime = newDateTime;
                        }, currentTime: DateTime.now(), locale: LocaleType.ru);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: sepheight,
                  ),
                  Expanded(
                    child: TextField(
                      controller: viewModel._time,
                      decoration: InputDecoration(
                        hintText: 'Время',
                        border: inputBorder,
                        focusedBorder: inputBorder,
                        enabledBorder: inputBorder,
                        filled: true,
                        contentPadding: const EdgeInsets.all(8),
                      ),
                      onTap: () {
                        DatePicker.showTimePicker(
                          context,
                          showTitleActions: true,
                          showSecondsColumn: false,
                          onConfirm: (date) {
                            viewModel._time.text = tf.format(date);
                            final newDateTime = DateTime(
                              viewModel.selectedDateTime.year,
                              viewModel.selectedDateTime.month,
                              viewModel.selectedDateTime.day,
                              date.hour,
                              date.minute,
                            );

                            viewModel.selectedDateTime = newDateTime;
                            // '${date.hour}:${date.minute}';
                          },
                          currentTime: DateTime.now(),
                          locale: LocaleType.ru,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: sepheight * 1.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: viewModel.checkFields()
                              ? viewModel.register
                              : null,
                          child: const Text("Регистрация"))),
                  const SizedBox(
                    width: 20,
                  ),
                  const Expanded(
                      child: ElevatedButton(
                          //
                          onPressed: AppNavigator.toAuth,
                          child: Text("Назад"))),
                ],
              ),
              Flexible(
                flex: 3,
                child: Container(),
              ),
              if (viewModel.state.isLoading) const CircularProgressIndicator(),
              if (viewModel.state.errorText != null)
                Text(viewModel.state.errorText!)
            ],
          ),
        ),
      ),
    );
  }

  // Future<TimeOfDay?> pickTime() =>
  //     showTimePicker(context: context, initialTime: TimeOfDay.now());

  static Widget create() => ChangeNotifierProvider<_ViewModel>(
        create: (context) => _ViewModel(context: context),
        child: const Register(),
      );
}
