#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

#define BUFFER_SIZE 1024

int main(int argc , char*argv[])
{
    int client_socket;
    struct sockaddr_in server_address; //struct to hold server address
    char buffer[BUFFER_SIZE] = {0};
    char command[BUFFER_SIZE] = {0};
    if (argc != 3) //if program doesnt recieve 3 arguments (automatic) program name , ip address , port no
    {
        printf("Error in passing arguments\n");
        exit(EXIT_FAILURE);
    }
    //creating the socket
    if((client_socket=socket(AF_INET,SOCK_STREAM,0)) < 0)
    {
        printf("Error creating clients socket");
        exit(EXIT_FAILURE);
    }
    server_address.sin_family = AF_INET;
    server_address.sin_port = htons(atoi(argv[2])); //passes 3rd argument witch is port to the adresses struct
    if (inet_pton(AF_INET, argv[1],&server_address.sin_addr) <= 0) // checks second argument ip address is valid
    {
        printf("wrong passing of ip address\n");
        exit(EXIT_FAILURE);
    }
    if ((connect(client_socket,(struct sockaddr*)&server_address,sizeof(server_address))) < 0)
    {
        printf("Connection failed\n");
        exit(EXIT_FAILURE);
    }

    while (1)
    {
        printf("Enter command to execute: ");
        fgets(command,BUFFER_SIZE,stdin); //get the command from the user
        command[strlen(command)-1]; // to remove \n 

        send(client_socket,command,strlen(command),0); //send the command


        if (strncmp(command, "stop", 4) == 0)
        {
            break;//check for stop command and if true end the program
        }
        int exit_status;
        read(client_socket, &exit_status, sizeof(exit_status)); //read exit status from server
        exit_status = ntohl(exit_status); // Convert from network byte order
        printf("Command exit status: %d\n", exit_status);
        if (exit_status == 0)
        {
            "Command or program exited succesfully\n";
        }
        else
        {
            "Something went wrong\n";
        }
    }
    close(client_socket);
    return 0;
    
}