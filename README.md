# flutter_password_validator
Flutter Password Validator package helps you to validate password with customized rules.

![alt text](https://github.com/intforce-software/flutter_password_validator/blob/main/Flutter%20Password%20validator.gif?raw=true)

# How to Use
**1. Add Package to pubspec.yaml file**

```dart
dependencies:
  flutter:
     sdk: flutter

  flutter_password_validator:
    git:
       url:https://github.com/intforce-software/flutter_password_validator
    ref: main
```
*Note- Make sure, you add main branch as ref*

**2. Install**

```dart
flutter pub get
```

**3. Import**

Import validator file like below whever you want to use Validation control

```dart
import 'package:flutter_password_validator/flutter_Password_validator.dart';
```

After import, write below code under password TextField and pass the controller as shown below

```dart
new TextField(
    controller: _passwordController
),
new FlutterPwValidator(
    controller: _passwordController,
    minLength: 8,
    uppercaseCharCount: 2,
    numericCharCount: 1,
    specialCharCount: 1,
    width: 400,
    height: 150,
    onSuccess: yourCallbackFunction,
    onFail: yourCallbackFunction
)
```

**4. Properties**
Below are additional properties which you can set/customize in ```new FlutterPwValidator```. 


| Property | Description | Default Value | Required |
| ------------- | ------------- | ------------- | ------------- |
| controller | Takes your password TextField controller | null | Yes |
| minLength | Takes total minimum length of password | null | Yes |
| uppercaseCharCount | Takes minimum uppercase character count that has to include in the password | 0 | No |
| numericCharCount | Takes minimum numeric character count that has to include in the password | 0 | No |
| specialCharCount | Takes minimum special character count that has to include in the password  | 0 | No |
| width | Takes the widget width | null | Yes |
| height | Takes the widget height | null | Yes |
| onSuccess | A void callback function that runs when the password is matched with the condition(s) | null | Yes |
| onFail | A void callback that gets called everytime the password doesn't match with the condition(s) | null | No |
| defaultColor | Takes default state color of the widget | ![#d3d3d3](https://via.placeholder.com/15/d3d3d3/000000?text=+) ```Color(0xFFd3d3d3)``` | No |
| barOneColor | Takes barOne state color of the widget | ![#C81919](https://via.placeholder.com/15/C81919/000000?text=+) ```Color(0xFFC81919)``` | No |
| barTwoColor | Takes barTwo state color of the widget | ![#FFAC1D](https://via.placeholder.com/15/FFAC1D/000000?text=+) ```Color(0xFFFFAC1D)``` | No |
| barThreeColor | Takes barThree state color of the widget | ![#A6C061](https://via.placeholder.com/15/A6C061/000000?text=+) ```Color(0xFFA6C061)``` | No | 
| barFourColor | Takes barFour state color of the widget | ![#1AAF09](https://via.placeholder.com/15/1AAF09/000000?text=+) ```Color(0xFF1AAF09)``` | No |
| strings | A class implementing the default ``` FlutterPasswordValidatorStrings ``` | English   ```FlutterPasswordValidatorStrings``` | No |


# Sample Code 
Check <a href="https://github.com/intforce-software/flutter_password_validator/tree/main/example">example project</a> to see working sample.
