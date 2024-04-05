//gcc -o ex1 ex1.c && ./ex1
#include <stdio.h>
#include <unistd.h>

int main()
{
        int pid;

        if ((pid = fork()) == -1) {
                fprintf(stderr, "can't fork\n");
        }
        else if (pid == 0) {
                fprintf(stdout, "this is a child process\n");
                fprintf(stderr, "pid(child)=%d\n", pid);
        }
        else{
                fprintf(stdout, "this is a parent process\n");
                fprintf(stderr, "pid(parent)=%d\n",pid);
        }
        return 0;
}