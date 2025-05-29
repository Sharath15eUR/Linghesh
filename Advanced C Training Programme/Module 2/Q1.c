#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>
#include <stdbool.h>

int N;  

bool is_prime(int num) {
    if (num < 2) return false;
    for (int i = 2; i * i <= num; i++) {
        if (num % i == 0) return false;
    }
    return true;
}


void* sum_of_primes(void* arg) {
    int count = 0, num = 2, sum = 0;

    while (count < N) {
        if (is_prime(num)) {
            sum += num;
            count++;
        }
        num++;
    }

    printf("Sum of first %d prime numbers is: %d\n", N, sum);
    pthread_exit(NULL);
}

void* thread1_func(void* arg) {
    int hundred = 0;
    while (hundred < 100) {
        printf("Thread 1 running\n");
        sleep(2);
        hundred += 2;
    }
    pthread_exit(NULL);
}


void* thread2_func(void* arg) {
    int hundred = 0;
    while (hundred < 100) {
        printf("Thread 2 running\n");
        sleep(3);
        hundred += 3;
    }
    pthread_exit(NULL);
}

int main() {
    printf("Enter N (number of primes to sum): ");
    scanf("%d", &N);

    pthread_t threadA, threadB, threadC;

    pthread_create(&threadA, NULL, sum_of_primes, NULL);
    pthread_create(&threadB, NULL, thread1_func, NULL);
    pthread_create(&threadC, NULL, thread2_func, NULL);

    pthread_join(threadA, NULL);
    pthread_join(threadB, NULL);
    pthread_join(threadC, NULL);

    printf("All threads completed.\n");

    return 0;
}


