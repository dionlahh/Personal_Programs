#include <stdio.h>

int to_bin(int d);

int main() {
    int dec = 8;
    printf("Integer: %d\nBinary: %d\n", dec, to_bin(dec));
    return 0;
}

int to_bin(int d) {
    if (d == 0) {
        return 0;
    }
    else if (d == 1) {
        return 1;
    }
    else {
        int result = to_bin(d/2);
        result = result * 10 + (d%2);
        return result;
    }
}



