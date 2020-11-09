class Validator {
  String validateName(String value) {
    String pattern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Your Name can't empty";
    } else if (!regExp.hasMatch(value)) {
      return "Your Name must be a-z and A-Z";
    }
    return null;
  }

  String validateEmail(String value) {
    var regexEmail = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    if (value.length == 0) {
      return "Your email can't empty";
    }
    if (!regexEmail.hasMatch(value)) {
      return "Your email is not valid";
    }
    return null;
  }

  String validatePhoneNumber(String value) {
    if(value.length == 0) {
      return "Your phone number can't empty";
    }
    if((!(value.length == 10 || value.length == 11) && value[0] == "0") ||
        (!(value.length == 11 || value.length == 12) && value[0] == "84") ||
        (!(value.length == 12 || value.length == 13) && value[0] == "+84")
    ) {
      return "Your phone number is not valid";
    }
    var regexPhone = RegExp(r"(09|01[2|6|8|9])+([0-9]{8})\b");
    if(!regexPhone.hasMatch(value)) {
      return "Your phone number is not valid";
    }
    return null;
  }

  String validatePassword(String value) {
    if(value.length==0){
      return "Your Password can't be empty";
    } else if (value.length < 8){
      return "Your Password must be longer than 8 characters";
    }
    return null;
  }
}