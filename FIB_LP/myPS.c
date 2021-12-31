#include <stdlib.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>

int main (int argc, char *argv[])
{
	char buf[80];
int pid,i;
	for(i=0;i<argv[1];i++){
		 pid=fork();}
	switch (pid){
		case 0: sprintf(buf,"Nooo (hijo)%d, arg=%s \n",getpid(),argv[1]);
			write(1,buf,strlen(buf));
		default: sprintf(buf,"yo soy tu padre: %d, arg=%s \n",getpid(),argv[1]);	
			write(1,buf,strlen(buf));
	}
	while (1);
}
