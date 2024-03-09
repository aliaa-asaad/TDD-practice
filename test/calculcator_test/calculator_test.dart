import 'package:arabic_testing/calculator/calculator_model.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  test('Add method should return 5 if the inputs are 3 and 2', () {
    ///AAA

    //arrange
    final calc = Calculator();
    const num1 = 3;
    const num2 = 2;
    const expectedResult = 5;

    //act
    final result = calc.add(num1, num2);

    //assert
    expect(result, expectedResult);
  });

  test('DivideBy method should return 5 if the inputs are 10 and 2', () {
    //arrange
    final calc = Calculator();
    const num1 = 10;
    const num2 = 2;
    const expectedResult = 5;

    //act
    final result = calc.divideBy(num1, num2);

    //assert
    expect(result, expectedResult);
  });

  test('DivideBy method should throw an Exception if num2 is 0', () {
    //arrange
    final calc = Calculator();
    const num1 = 10;
    const num2 = 0;
    final expectedResult = throwsA(isA<Exception>());

    //act
    //////////////
    ///هنا هو خلي الريزالت فانكشن ومش الريزالت كفاريابل عشان الاكسبشن يرجع طب ازاي مش هيرجع فالفاريابل
    //////////////
    // final result = () => calc.divideBy(num1, num2);
    
    ///////////
    /// هو ليه رجع الفانكشن دي ومش رجع الريزلت كفاريابل
    /////////////
    result() => calc.divideBy(num1, num2);

    //assert
    expect(result, expectedResult);
  });
}