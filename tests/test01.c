#include <stdio.h>

int main(void) {
    int a;
    scanf("%d", &a);
    int b = 5;
    if (a > 50) {
        for (int i = 0; i < a * a; ++i)
            b *= i;
        printf("%d\n", b);
    } else {
        scanf("%d", &a);
        for (int i = 0; i < a * a * a; ++i)
            b *= i;
        printf("%d\n", b);
    }
}
