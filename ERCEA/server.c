#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <signal.h>
#include <sys/wait.h>
#include <sys/socket.h>

#define PORT 8080
#define BUFFER_SIZE 1024

//handler if sigint ctrl + c recieved
void sigint_handler(int sig)
{
    printf("SIGINT RECIEVED SUCCSEFULY\n");
    exit(0);
}

void clean_zombie()
{
    while (waitpid(-1, NULL, WNOHANG) > 0); 
}


void execute_command(int client_socket);

int main()
{

    int myserver , myclient;
    // structure containing servers address
    struct sockaddr_in address;
    socklen_t address_len= sizeof(address);
    
    signal(SIGINT,sigint_handler);

    int error;
    if ((myserver=socket(AF_INET,SOCK_STREAM,0)) < 0)
    {
        //Condition to check if socket is created
        printf("Socket failed to create\n");
        exit(EXIT_FAILURE);
    }
    address.sin_family= AF_INET;
    address.sin_port = htons(PORT);
    address.sin_addr.s_addr = INADDR_ANY; //connects to any available network interface

    if ((bind(myserver,(struct sockaddr *)&address, address_len)) < 0)
    {
        printf("Error binding socket\n");
        close(myserver);
        exit(EXIT_FAILURE);
    }

    if ((listen(myserver,1)) < 0)
    {
        printf("Listen failed\n");
        close(myserver);
        exit(EXIT_FAILURE);
    }

    printf("Server listening on port %d\n",PORT);

    while(1)
    {
        if ((myclient = accept(myserver, (struct sockaddr *)&address, (socklen_t *)&address_len)) < 0) {
            printf("Accept failed\n");
        }


        if (fork()==0)
        {
            close(myserver);
            execute_command(myclient);
            exit(0);
        }
        else
        {
            close(myclient);
            clean_zombie(); // function to clean up zombie procceses non blocking for the parent allowing it to accept several clients
        }
    }

    close(myserver);
    return 0;

}

void execute_command(int client_socket)
{
    char Buffer[BUFFER_SIZE]={0}; //buffer to hold command
    int exit_status; //value to determine exit state of the command
    while(1)
    {
        memset(Buffer,0,1024); //clear buffer from 0 up to size
        int bytes_read=read(client_socket,Buffer,BUFFER_SIZE);
        if (bytes_read <= 0)
        {
            printf("Connection closed or reading failed\n");
            close(client_socket);
            return;
        }
        else
        {
            printf("Recieved command succesfully\n");
            printf("Command: %s\n",Buffer);
        }
        if (strncmp(Buffer, "cd ", 3) == 0) //if condition to handle cd command
        {
            char * dir = Buffer + 3; //Remove the cd part and extract directory name
            chdir(dir); //function to change directory
            exit_status = htonl(exit_status); // Convert to network byte order
            write(client_socket, &exit_status, sizeof(exit_status));
            continue;
        }
        if (strncmp(Buffer, "stop", 4) == 0) //special condition if the command is stop close the connection
        {
            close(client_socket);
            return;
        }
        
                
        exit_status=system(Buffer);//executes the command and returns exit state 
        exit_status=htonl(exit_status);//converts exit status to network in order to return it to client
        write(client_socket,&exit_status,sizeof(exit_status));//returns state to client
        
    }
}