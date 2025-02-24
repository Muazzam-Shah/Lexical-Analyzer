#include <iostream>
using namespace std;

int main() {
    int num1 = 10;
    int num2 = 20;
    float result_ = 0.0;
    // RESULT IN NEXT
    result_ = num1 + num2;

    cout << "The result is: " << result_ << endl;

    if (result_ > 0) {
        cout << "Result is positive." << endl;
    } else {
        cout << "Result is non-positive." << endl;
    }

    return 0;
}
