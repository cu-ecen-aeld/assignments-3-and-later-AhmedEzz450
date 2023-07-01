#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <syslog.h>

int main(int argc, char *argv[])
{
	int fd;
	int exit = 0;
	openlog("[aesd_ass2_writer.c]", 0, LOG_USER);	
	if (argc < 3){	
		perror("Too few arguments!!\nyou must enter the file path and string to be written.");
		syslog(LOG_ERR, "[%d]Too few arguments!!\nyou must enter the file path and string to be written.", argc);
		exit = 1;
	}
	else if (argc > 3){	
		perror("Too many arguments!!\nyou must enter the file path and string to be written.");
		syslog(LOG_ERR, "[%d]Too many arguments!!", argc);
		exit = 1;
	}
	else {
		fd = open(argv[1], O_WRONLY | O_CREAT);
		if (fd == -1){
			perror("open");
			syslog(LOG_ERR, "failed to open file %s ", argv[1]);
			exit = 1;
		}
		else{
			write(fd, argv[2], strlen(argv[2]));
			syslog(LOG_DEBUG, "writing \"%s\" to %s", argv[2], argv[1]);
			close(fd);
		}
	}
	return exit;
}
