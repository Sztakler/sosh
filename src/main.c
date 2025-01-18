#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistdio.h>
#include <unistd.h>
#include <sys/wait.h>

#define MAX_INPUT 1024
#define MAX_ARGS 100

void parse_input(char *input, char **args) {
  int i = 0;
  args[i] = strtok(input, " \n");

  while (args[i] != NULL) {
    i++;
    args[i] = strtok(NULL, " \n");
  }
}

int main(int argc, char** argv) {

  char input[MAX_INPUT];
  char *args[MAX_ARGS];
  pid_t pid;
  int status;

  while (1) {
    printf("$");
    fflush(stdout);

    if (fgets(input, MAX_INPUT, stdin) == NULL) {
      printf("\nExiting shell...\n");
      break;
    }

    if (strlen(input) > 0 && input[strlen(input)  -1] == '\n') {
      input[strlen(input) - 1] = '\0';
    }

    parse_input(input, args);

    if (args[0] == NULL) {
      continue;
    } else if (strcmp(args[0], "exit") == 0) {
      printf("Goodbye\n");
      break;
    }

    pid = fork();

    if (pid == 0) {
      if (execvp(args[0], args) == -1) {
        perror("Error executing command");
      }
      exit(EXIT_FAILURE);
    } else if (pid < 0) {
      perror("Fork failed");
    } else {
      waitpid(pid, &status, 0);
    }
  }
}
