
#!/bin/bash

Dir_Name=$1

if [ -d $1 ]; then
	rm -r  $Dir_Name
	echo "Error: File trying to create already exits"
	echo "Deleting directory and exiting.."
	exit
else
	mkdir $Dir_Name
	cd $Dir_Name
	touch main.c hello.c main.h hello.h
        echo "directory and included files created succesfuly"
fi

for file in $(ls)
do
	echo this file is named $file >> $file
done
        echo "Writting to files successful"

cd ../
tar --remove-files  -cf "${Dir_Name}.tar" $Dir_Name
echo "Directory compressed successfully"

tar_path=/home/ahmed/Desktop/final_project/"${Dir_Name}.tar"


cd  ../../../../../home/final_project_user
echo "Current directory: $(pwd)"

if  sudo cp $tar_path . ; then
	echo "Tar file copied successfully"
else
	echo "Error:Tar file cant be copied"
	exit
fi

if  sudo tar -xf "${Dir_Name}.tar" ;  then
	echo "File extracted successfully"
else
	echo "File cant be extracted"
	exit
fi
