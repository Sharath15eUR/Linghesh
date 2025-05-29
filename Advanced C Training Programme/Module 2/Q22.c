#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <stdbool.h>

int x;

bool prime(int n) {
    if (n < 2) return 0;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return 0;
    }
    return 1;
}

void sumprimes() {
    int a = 0, b = 2, sum = 0;
    while (a < x) {
        if (prime(b)) {
            sum += b;
            a++;
        }
        b++;
    }
    printf("sum of first %d primes is %d\n", x, sum);
}

void t1() {
    int t = 0;
    while (t < 100) {
        printf("Thread 1 running\n");
        sleep(2);
        t += 2;
    }
}

void t2() {
    int z = 0;
    while (z < 100) {
        printf("Thread 2 running\n");
        sleep(3);
        z += 3;
    }
}

int main() {
    printf("Enter a number: ");
    scanf("%d", &x);

    sumprimes();
    t1();
    t2();
    return 0;
}
