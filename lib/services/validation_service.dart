String? validateLogin(String? value) {
  
  if (value == null || value.isEmpty) {
    return 'Введите логин';
  }

  return null;
}

String? validatePassword(String? value) {

  if (value == null || value.isEmpty) {
    return 'Введите пароль';
  }
  
  return null;
}