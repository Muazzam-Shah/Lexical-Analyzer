#include <iostream>

using namespace std;

// Function to calculate factorial
int factorial(int n) {
    if (n == 0 || n == 1)
        return 1;
    else
        return n * factorial(n - 1);
}

int main() {
    int number;
    
    cout << "Enter a number: ";
    cin >> number;
    
    // Call the factorial function and display the result
    cout << "Factorial of " << number << " is: " << factorial(number) << endl;
    
    return 0;
}
