#include <unistd.h>

#define BUFSIZE (128)

int main()
{
        int pid;
        int fd[2];
        if (pipe(fd) == -1){
                fprintf(stderr, "Can't create pipe\n");
                exit(1);
        }
        printf("fd[0]=%d fd[1]=%d\n",fd[0], fd[1]);

        if ((pid = fork()) == 0) {
                char buf[BUFSIZE];
                int len;
                close(fd[1]);
                len = read(fd[0], buf, BUFSIZE);
                close(fd[0]);
                fprintf(stderr, "child finished, len=%d\n", len);
        }
        else{
                char buf[] = "hello world";
                close(fd[0]);
                write(fd[1], buf , sizeof(buf));
                close(fd[1]);
                fprintf(stderr, "parent finished\n");
        }
        return 0;
}