Project Components
1. Enhanced Remote Command Execution Application (ERCEA)
    Client-Server Architecture: This system allows a client to send commands to a remote server, which executes them and returns the exit status to the client.
   Features:
    Client connects to the server using an IP and port.
    Commands can include arguments and flags, and the server executes them.
    Server supports multiple clients simultaneously using child processes.
    Graceful termination upon receiving the SIGINT signal.
    Server handles zombie processes to avoid resource leakage.
2. Bash Scripts
    Script 1: Automates the setup of user accounts and groups with specified properties and permissions.
    Script 2: Manages the creation of project directories and files, ensuring persistent configurations for system users and administrators.
3. Makefile Project
    Build system using Makefiles to automate the compilation and linking of the Caesar cipher and XOR cipher cryptographic modules.
    Generates the static and dynamic libraries for these modules.
    Ensures correct directory creation (gen, libs, etc.) and cleaning processes.
4. CMake Project
    Alternative build system using CMake for the cryptographic libraries and application.
    Organizes source files, libraries, and executables for both the Caesar cipher (static library) and XOR cipher (dynamic library).
    Supports modern CMake practices for clean and modular project builds.
5. Client-Server Source Files
    Client: Connects to the server using TCP, sends commands for remote execution, and prints the command’s exit status received from the server.
    Server: Receives and executes commands from clients, returns exit statuses, and handles multiple connections by spawning child processes
