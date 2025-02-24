#include <iostream>

// Define a constant for the value of PI
#define PI 3.14159

using namespace std;

int main() {
    double radius = 5.0;
    
    // Calculate the area of a circle using the defined PI constant
    double area = PI * radius * radius;
    
    cout << "The area of the circle with radius " << radius << " is: " << area << endl;
    
    return 0;
}
