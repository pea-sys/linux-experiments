#define BUFSIZE (128)

int main()
{
        int pid;
        int fd[2];
        if (pipe(fd) == -1){
                fprintf(stderr, "can't create pipe\n");
                exit(1);
        }

        if ((pid = fork()) == 0) {
                int in;
                close(fd[1]);
                close(0);
                in = dup(fd[0]);
                close(fd[0]);
                fprintf(stderr,"in=%d\n", in);
                fprintf(stderr, "child : exec wc\n");
                execl("/usr/bin/wc","wc",NULL);
        }
        else{
                int out;
                close(fd[0]);
                close(1);
                out=dup(fd[1]);
                close(fd[1]);
                fprintf(stderr, "out=%d\n", out);
                fprintf(stderr, "parent: exec echo 'hello world\n'");
                execl("/bin/echo","echo","hello world",NULL);
        }
        return 0;
}